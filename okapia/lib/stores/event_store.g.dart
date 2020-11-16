// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventStore<M> on _EventStore<M>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount => (_$totalCountComputed ??=
          Computed<int>(() => super.totalCount, name: '_EventStore.totalCount'))
      .value;

  final _$dataAtom = Atom(name: '_EventStore.data');

  @override
  ObservableList<EventModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<EventModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_EventStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$refreshAsyncAction = AsyncAction('_EventStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$fetchMoreAsyncAction = AsyncAction('_EventStore.fetchMore');

  @override
  Future<void> fetchMore() {
    return _$fetchMoreAsyncAction.run(() => super.fetchMore());
  }

  final _$updateAsyncAction = AsyncAction('_EventStore.update');

  @override
  Future<void> update(int id, String title, DateTime eventTime) {
    return _$updateAsyncAction.run(() => super.update(id, title, eventTime));
  }

  final _$createAsyncAction = AsyncAction('_EventStore.create');

  @override
  Future<void> create(String title, DateTime eventTime) {
    return _$createAsyncAction.run(() => super.create(title, eventTime));
  }

  final _$deleteAsyncAction = AsyncAction('_EventStore.delete');

  @override
  Future<void> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
data: ${data},
isLoading: ${isLoading},
totalCount: ${totalCount}
    ''';
  }
}
