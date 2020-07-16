// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemListStore<M extends StructuredMeta, C extends StructuredContent>
    on _ItemListStore<M, C>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount)).value;

  final _$dataAtom = Atom(name: '_ItemListStore.data');

  @override
  ObservableList<ListItemModel<M>> get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(ObservableList<ListItemModel<M>> value) {
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

  final _$createOrUpdateRawRecordAsyncAction =
      AsyncAction('createOrUpdateRawRecord');

  @override
  Future<void> createOrUpdateRawRecord(String id, C item) {
    return _$createOrUpdateRawRecordAsyncAction
        .run(() => super.createOrUpdateRawRecord(id, item));
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<void> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }
}
