// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_edit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordEditStore on _PasswordEditStore, Store {
  final _$isSaveAbleAtom = Atom(name: '_PasswordEditStore.isSaveAble');

  @override
  bool get isSaveAble {
    _$isSaveAbleAtom.reportRead();
    return super.isSaveAble;
  }

  @override
  set isSaveAble(bool value) {
    _$isSaveAbleAtom.reportWrite(value, super.isSaveAble, () {
      super.isSaveAble = value;
    });
  }

  final _$createAsyncAction = AsyncAction('_PasswordEditStore.create');

  @override
  Future<void> create(
      String name, String account, String url, ProtectedValue password) {
    return _$createAsyncAction
        .run(() => super.create(name, account, url, password));
  }

  @override
  String toString() {
    return '''
isSaveAble: ${isSaveAble}
    ''';
  }
}
