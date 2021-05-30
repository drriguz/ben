import 'package:native_sqlcipher/native_sqlcipher.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class NoteCheckList {
  String? title;
  int? checkItems;
  int? finishedItems;
}

class NoteEvent {
  DateTime? time;
  String? title;
}

class NoteImage {
  String? thumb;
  String? path;
}

class NoteLocation {
  String? title;
  String? location;
}

class NoteModel extends Entity {
  String? title;
  List<NoteCheckList>? checklists;
  List<NoteEvent>? events;
  List<NoteImage>? images;
  String? content;

  static final String TABLE = "note";
  static final String FIELDS = "title, content";

  NoteModel(
      {int? id, this.title, this.content, int? createdTime, int? lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static NoteModel fromResult(Row r) {
    return NoteModel(
      id: r.readColumnAsInt("id"),
      title: r.readColumnAsText("title"),
      content: r.readColumnAsText("content"),
      createdTime: r.readColumnAsInt64("created_time"),
      lastUpdatedTime: r.readColumnAsInt64("last_updated_time"),
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
