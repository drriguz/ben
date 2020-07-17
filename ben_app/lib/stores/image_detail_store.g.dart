// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageDetailStore on _ImageDetailStore, Store {
  final _$itemAtom = Atom(name: '_ImageDetailStore.item');

  @override
  ImageProvider<dynamic> get item {
    _$itemAtom.context.enforceReadPolicy(_$itemAtom);
    _$itemAtom.reportObserved();
    return super.item;
  }

  @override
  set item(ImageProvider<dynamic> value) {
    _$itemAtom.context.conditionallyRunInAction(() {
      super.item = value;
      _$itemAtom.reportChanged();
    }, _$itemAtom, name: '${_$itemAtom.name}_set');
  }

  final _$_ImageDetailStoreActionController =
      ActionController(name: '_ImageDetailStore');

  @override
  Future<void> fetch() {
    final _$actionInfo = _$_ImageDetailStoreActionController.startAction();
    try {
      return super.fetch();
    } finally {
      _$_ImageDetailStoreActionController.endAction(_$actionInfo);
    }
  }
}
