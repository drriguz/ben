// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventDetailStore on _EventDetailStore, Store {
  final _$_dataAtom = Atom(name: '_EventDetailStore._data');

  @override
  EventModel get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(EventModel value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$selectedDateAtom = Atom(name: '_EventDetailStore.selectedDate');

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  final _$selectedTimeAtom = Atom(name: '_EventDetailStore.selectedTime');

  @override
  TimeOfDay get selectedTime {
    _$selectedTimeAtom.reportRead();
    return super.selectedTime;
  }

  @override
  set selectedTime(TimeOfDay value) {
    _$selectedTimeAtom.reportWrite(value, super.selectedTime, () {
      super.selectedTime = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_EventDetailStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$selectEventDateAsyncAction =
      AsyncAction('_EventDetailStore.selectEventDate');

  @override
  Future<void> selectEventDate(DateTime date) {
    return _$selectEventDateAsyncAction.run(() => super.selectEventDate(date));
  }

  final _$selectEventTimeAsyncAction =
      AsyncAction('_EventDetailStore.selectEventTime');

  @override
  Future<void> selectEventTime(TimeOfDay time) {
    return _$selectEventTimeAsyncAction.run(() => super.selectEventTime(time));
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
selectedTime: ${selectedTime}
    ''';
  }
}
