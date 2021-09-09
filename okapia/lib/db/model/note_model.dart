import 'package:native_sqlcipher/native_sqlcipher.dart';

import 'entity.dart';

class NoteModel extends Entity {
  String? title;
  String? content;

  static final String TABLE = "note";
  static final String FIELDS = "title, content";

  NoteModel({
    int? id,
    int? createdTime,
    int? lastUpdatedTime,
    this.title,
    this.content,
  }) : super(id, createdTime, lastUpdatedTime);

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
