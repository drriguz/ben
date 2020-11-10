import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class NoteModel extends Entity {
  String title;
  String content;

  static final String TABLE = "note";
  static final String FIELDS = "title, content";

  NoteModel(
      {String id,
      this.title,
      this.content,
      DateTime createdTime,
      DateTime lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static NoteModel fromResult(Row r) {
    return NoteModel(
      id: r.readColumnAsText("id"),
      title: r.readColumnAsText("title"),
      content: r.readColumnAsText("content"),
      createdTime: DateTime.parse(r.readColumnAsText("created_time")),
      lastUpdatedTime: DateTime.parse(r.readColumnAsText("last_updated_time")),
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
