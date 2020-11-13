// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteStore<M> on _NoteStore<M>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount => (_$totalCountComputed ??=
          Computed<int>(() => super.totalCount, name: '_NoteStore.totalCount'))
      .value;

  final _$dataAtom = Atom(name: '_NoteStore.data');

  @override
  ObservableList<NoteModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<NoteModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_NoteStore.isLoading');

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

  final _$refreshAsyncAction = AsyncAction('_NoteStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$fetchMoreAsyncAction = AsyncAction('_NoteStore.fetchMore');

  @override
  Future<void> fetchMore() {
    return _$fetchMoreAsyncAction.run(() => super.fetchMore());
  }

  final _$updateAsyncAction = AsyncAction('_NoteStore.update');

  @override
  Future<void> update(int id, String content) {
    return _$updateAsyncAction.run(() => super.update(id, content));
  }

  final _$createAsyncAction = AsyncAction('_NoteStore.create');

  @override
  Future<void> create(String content) {
    return _$createAsyncAction.run(() => super.create(content));
  }

  final _$deleteAsyncAction = AsyncAction('_NoteStore.delete');

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
