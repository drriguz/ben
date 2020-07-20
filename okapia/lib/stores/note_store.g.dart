// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteStore<M> on _NoteStore<M>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount)).value;

  final _$dataAtom = Atom(name: '_NoteStore.data');

  @override
  ObservableList<BriefNoteData> get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(ObservableList<BriefNoteData> value) {
    _$dataAtom.context.conditionallyRunInAction(() {
      super.data = value;
      _$dataAtom.reportChanged();
    }, _$dataAtom, name: '${_$dataAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$updateAsyncAction = AsyncAction('update');

  @override
  Future<void> update(String id, String content) {
    return _$updateAsyncAction.run(() => super.update(id, content));
  }

  final _$createAsyncAction = AsyncAction('create');

  @override
  Future<void> create(String content) {
    return _$createAsyncAction.run(() => super.create(content));
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<void> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }
}
