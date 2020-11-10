import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class NoteModel extends Entity {
  String title;
  String content;

  static final String TABLE = "note";
  static final String FIELDS = "title, content";

  NoteModel(
      {int id, this.title, this.content, int createdTime, int lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static NoteModel fromResult(Row r) {
    return NoteModel(
      id: r.readColumnAsInt("id"),
      title: r.readColumnAsText("title"),
      content: r.readColumnAsText("content"),
      createdTime: r.readColumnAsInt("created_time"),
      lastUpdatedTime: r.readColumnAsInt("last_updated_time"),
    );
  }

  @override
  String toSqlValues() {
    return "'$title', '$content'";
  }

  @override
  String toUpdateSql() {
    return "title='$title', content='$content'";
  }
}
