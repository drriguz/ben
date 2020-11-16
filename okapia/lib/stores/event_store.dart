import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:mobx/mobx.dart';
import 'package:okapia/services/event_service.dart';
import 'package:okapia/services/note_service.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'event_store.g.dart';

class EventStore = _EventStore with _$EventStore;

abstract class _EventStore<M> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final EventService _eventService;
  int lastId = -1;

  @observable
  ObservableList<EventModel> data = ObservableList<EventModel>();

  @observable
  bool isLoading = false;

  _EventStore(this._userStore, this._eventService) {}

  @action
  Future<void> refresh() async {
    setBusy();
    data.clear();
    return _eventService.refresh(_userStore.database).then((items) {
      if (items.isNotEmpty) {
        lastId = items.last.id;
        data.addAll(items);
      }
    }).whenComplete(() => setIdle());
  }

  @action
  Future<void> fetchMore() async {
    isLoading = true;

    return _eventService.fetch(_userStore.database, lastId).then((items) {
      if (items.isNotEmpty) {
        lastId = items.last.id;
        data.addAll(items);
      }
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> update(int id, String title, DateTime eventTime) async {
    setBusy();
    EventModel existing = data.firstWhere((element) => element.id == id);
    assert(existing != null);

    existing.title = title;
    existing.eventTime = eventTime.millisecondsSinceEpoch;

    _eventService
        .update(_userStore.database, existing)
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String title, DateTime eventTime) async {
    setBusy();
    EventModel note =
        EventModel(title: title, eventTime: eventTime.millisecondsSinceEpoch);
    _eventService
        .create(_userStore.database, note)
        .then((created) => data.insert(0, created))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(int id) async {
    setBusy();
    _eventService
        .delete(_userStore.database, id)
        .then((id) => data.removeWhere((element) => element.id == id))
        .whenComplete(() => setIdle());
  }

  @computed
  int get totalCount => data.length;
}
