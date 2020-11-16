import 'package:native_sqlcipher/database.dart';

import '../repository.dart';

class EventModel extends Entity {
  String title;
  int eventTime;
  int noteId;

  static final String TABLE = "event";
  static final String FIELDS = "title, event_time";

  EventModel(
      {int id,
      this.title,
      this.eventTime,
      this.noteId,
      int createdTime,
      int lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static EventModel fromResult(Row r) {
    return EventModel(
      id: r.readColumnAsInt("id"),
      title: r.readColumnAsText("title"),
      eventTime: r.readColumnAsInt64("event_time"),
      createdTime: r.readColumnAsInt64("created_time"),
      lastUpdatedTime: r.readColumnAsInt64("last_updated_time"),
    );
  }

  @override
  String toSqlValues() {
    return "'$title', $eventTime";
  }

  @override
  String toUpdateSql() {
    return "title='$title', event_time=$eventTime";
  }
}
