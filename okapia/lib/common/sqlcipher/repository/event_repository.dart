import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class EventRepository extends Sqlite3Repository<EventModel> {
  EventRepository()
      : super(EventModel.TABLE, Entity.FIELDS + EventModel.FIELDS);

  @override
  EventModel merge(EventModel existing, EventModel updated) {
    existing.title = updated.title;
    existing.eventTime = updated.eventTime;
    return existing;
  }

  @override
  EventModel convert(Row row) {
    return EventModel.fromResult(row);
  }
}
