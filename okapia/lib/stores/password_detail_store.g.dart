// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordDetailStore on _PasswordDetailStore, Store {
  final _$_dataAtom = Atom(name: '_PasswordDetailStore._data');

  @override
  PasswordModel get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(PasswordModel value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$_secondaryPasswordVerifiedAtom =
      Atom(name: '_PasswordDetailStore._secondaryPasswordVerified');

  @override
  bool get _secondaryPasswordVerified {
    _$_secondaryPasswordVerifiedAtom.reportRead();
    return super._secondaryPasswordVerified;
  }

  @override
  set _secondaryPasswordVerified(bool value) {
    _$_secondaryPasswordVerifiedAtom
        .reportWrite(value, super._secondaryPasswordVerified, () {
      super._secondaryPasswordVerified = value;
    });
  }

  final _$_decryptingAtom = Atom(name: '_PasswordDetailStore._decrypting');

  @override
  bool get _decrypting {
    _$_decryptingAtom.reportRead();
    return super._decrypting;
  }

  @override
  set _decrypting(bool value) {
    _$_decryptingAtom.reportWrite(value, super._decrypting, () {
      super._decrypting = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_PasswordDetailStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$setSecondaryPasswordAsyncAction =
      AsyncAction('_PasswordDetailStore.setSecondaryPassword');

  @override
  Future<void> setSecondaryPassword(ProtectedValue secondaryPassword) {
    return _$setSecondaryPasswordAsyncAction
        .run(() => super.setSecondaryPassword(secondaryPassword));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
