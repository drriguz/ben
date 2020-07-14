// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemDetailStore<T extends StructuredContent>
    on _ItemDetailStore<T>, Store {
  final _$itemAtom = Atom(name: '_ItemDetailStore.item');

  @override
  T get item {
    _$itemAtom.context.enforceReadPolicy(_$itemAtom);
    _$itemAtom.reportObserved();
    return super.item;
  }

  @override
  set item(T value) {
    _$itemAtom.context.conditionallyRunInAction(() {
      super.item = value;
      _$itemAtom.reportChanged();
    }, _$itemAtom, name: '${_$itemAtom.name}_set');
  }

  final _$_ItemDetailStoreActionController =
      ActionController(name: '_ItemDetailStore');

  @override
  Future<void> fetch(String id) {
    final _$actionInfo = _$_ItemDetailStoreActionController.startAction();
    try {
      return super.fetch(id);
    } finally {
      _$_ItemDetailStoreActionController.endAction(_$actionInfo);
    }
  }
}
