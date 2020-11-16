import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/common/sqlcipher/repository/event_repository.dart';
import 'package:okapia/common/sqlcipher/repository/note_repository.dart';

class EventService {
  final EventRepository _eventRepository;

  EventService(this._eventRepository);

  Future<int> getTotalCount(final Database database) async {
    return _eventRepository.selectCount(database);
  }

  Future<List<EventModel>> fetch(final Database database, int lastId) async {
    String where = lastId < 0 ? "" : "where id < $lastId";
    return _eventRepository.select(
        database, "$where order by id desc limit 20");
  }

  Future<List<EventModel>> refresh(final Database database) async {
    return _eventRepository.select(database, "order by id desc limit 20");
  }

  Future<EventModel> fetchById(final Database database, int id) async {
    return _eventRepository.selectById(database, id);
  }

  Future<EventModel> create(
      final Database database, final EventModel note) async {
    assert(note.title != null);
    assert(note.eventTime != null);

    return _eventRepository.insert(database, note);
  }

  Future<EventModel> update(
      final Database database, final EventModel note) async {
    assert(note.id != null);
    assert(note.createdTime != null);
    assert(note.lastUpdatedTime != null);
    assert(note.title != null);
    assert(note.eventTime != null);

    return _eventRepository.update(database, note.id, note);
  }

  Future<int> delete(final Database database, int id) async {
    return _eventRepository.delete(database, id);
  }
}
