// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotesStore on _NotesStore, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount)).value;

  final _$_dataAtom = Atom(name: '_NotesStore._data');

  @override
  ObservableList<Item> get _data {
    _$_dataAtom.context.enforceReadPolicy(_$_dataAtom);
    _$_dataAtom.reportObserved();
    return super._data;
  }

  @override
  set _data(ObservableList<Item> value) {
    _$_dataAtom.context.conditionallyRunInAction(() {
      super._data = value;
      _$_dataAtom.reportChanged();
    }, _$_dataAtom, name: '${_$_dataAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }
}
