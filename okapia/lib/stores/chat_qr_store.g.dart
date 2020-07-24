// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qr_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatQrStore on _ChatQrStore, Store {
  final _$myKeyAtom = Atom(name: '_ChatQrStore.myKey');

  @override
  String get myKey {
    _$myKeyAtom.context.enforceReadPolicy(_$myKeyAtom);
    _$myKeyAtom.reportObserved();
    return super.myKey;
  }

  @override
  set myKey(String value) {
    _$myKeyAtom.context.conditionallyRunInAction(() {
      super.myKey = value;
      _$myKeyAtom.reportChanged();
    }, _$myKeyAtom, name: '${_$myKeyAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }
}
