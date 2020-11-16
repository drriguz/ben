import 'package:flutter/material.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/services/event_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'event_detail_store.g.dart';

class EventDetailStore = _EventDetailStore with _$EventDetailStore;

abstract class _EventDetailStore extends PageStatusNotifier with Store {
  final int _id;
  final UserStore _userStore;
  final EventService _noteService;

  @observable
  EventModel _data;

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);

  _EventDetailStore(this._id, this._userStore, this._noteService);

  @action
  Future<void> fetch() async {
    setBusy();
    return _noteService
        .fetchById(_userStore.database, _id)
        .then((data) => _data = data)
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> selectEventDate(DateTime date) async {
    selectedDate = date;
  }

  @action
  Future<void> selectEventTime(TimeOfDay time) async {
    selectedTime = time;
  }

  EventModel get data => _data;
}
