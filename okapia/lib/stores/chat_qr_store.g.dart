// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qr_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatQrStore on _ChatQrStore, Store {
  final _$myKeyAtom = Atom(name: '_ChatQrStore.myKey');

  @override
  String? get myKey {
    _$myKeyAtom.reportRead();
    return super.myKey;
  }

  @override
  set myKey(String? value) {
    _$myKeyAtom.reportWrite(value, super.myKey, () {
      super.myKey = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ChatQrStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  @override
  String toString() {
    return '''
myKey: ${myKey}
    ''';
  }
}
