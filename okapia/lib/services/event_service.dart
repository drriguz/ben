import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/repository/event_repository.dart';

import 'curd_service.dart';

class EventService extends CurdService<EventModel, EventRepository> {
  EventService(EventRepository repository) : super(repository);
}
