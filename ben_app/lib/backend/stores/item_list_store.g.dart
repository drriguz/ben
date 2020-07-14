// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemListStore<T extends StructuredContent> on _ItemListStore<T>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount)).value;

  final _$_dataAtom = Atom(name: '_ItemListStore._data');

  @override
  ObservableList<RawBriefRecord> get _data {
    _$_dataAtom.context.enforceReadPolicy(_$_dataAtom);
    _$_dataAtom.reportObserved();
    return super._data;
  }

  @override
  set _data(ObservableList<RawBriefRecord> value) {
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

  final _$persistAsyncAction = AsyncAction('persist');

  @override
  Future<void> persist(T item) {
    return _$persistAsyncAction.run(() => super.persist(item));
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<void> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }
}