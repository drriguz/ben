import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/model/note.dart';
import 'package:okapia/common/utils/random.dart';

class NoteService {
  Future<int> getTotalCount(final Database database) async {
    Row result = database.query("select count(*) from note;").first;
    return result.readColumnByIndexAsInt(0);
  }

  Future<List<NoteModel>> fetch(final Database database) async {
    Result result = database.query(
        "select id, title, created_time from note order by id desc limit 5;");
    List<NoteModel> list = new List<NoteModel>();
    for (Row r in result) {
      NoteModel note = NoteModel(
        id: r.readColumnAsText("id"),
        title: r.readColumnAsText("title"),
        createdTime: DateTime.parse(r.readColumnAsText("created_time")),
      );
      list.add(note);
    }
    return list;
  }

  Future<NoteModel> fetchById(final Database database, String id) async {
    Row r = database
        .query(
            "select id, title, content, created_time, last_updated_time from note where id='${id}';")
        .first;

    return NoteModel(
      id: r.readColumnAsText("id"),
      title: r.readColumnAsText("title"),
      content: r.readColumnAsText("content"),
      createdTime: DateTime.parse(r.readColumnAsText("created_time")),
      lastUpdatedTime: DateTime.parse(r.readColumnAsText("last_updated_time")),
    );
  }

  Future<NoteModel> create(
      final Database database, final NoteModel note) async {
    assert(note.title != null);
    assert(note.content != null);

    final String id = IDUtil.generateUUID();
    final DateTime now = DateTime.now();
    note.id = id;
    note.createdTime = now;
    note.lastUpdatedTime = now;
    database.execute("""
    insert into note(id, title, content, created_time, last_updated_time)
      values
      ('${id}', 
       '${note.title}', 
       '${note.content}', 
       '${note.createdTime.toIso8601String()}',
       '${note.lastUpdatedTime.toIso8601String()}');
    """);
    return note;
  }

  Future<NoteModel> update(
      final Database database, final NoteModel note) async {
    assert(note.id != null);
    assert(note.createdTime != null);
    assert(note.lastUpdatedTime != null);
    assert(note.title != null);
    assert(note.content != null);

    final DateTime now = DateTime.now();
    note.lastUpdatedTime = now;
    database.execute("""
    update note set
       title='${note.title}', 
       content='${note.content}', 
       last_updated_time='${note.lastUpdatedTime.toIso8601String()}'
    where id='${note.id}');
    """);
    return note;
  }
}
