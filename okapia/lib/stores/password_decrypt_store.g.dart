// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_decrypt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordDecryptStore on _PasswordDecryptStore, Store {
  final _$_secondaryPasswordVerifiedAtom =
      Atom(name: '_PasswordDecryptStore._secondaryPasswordVerified');

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

  final _$_secondaryPasswordCompletedAtom =
      Atom(name: '_PasswordDecryptStore._secondaryPasswordCompleted');

  @override
  bool get _secondaryPasswordCompleted {
    _$_secondaryPasswordCompletedAtom.reportRead();
    return super._secondaryPasswordCompleted;
  }

  @override
  set _secondaryPasswordCompleted(bool value) {
    _$_secondaryPasswordCompletedAtom
        .reportWrite(value, super._secondaryPasswordCompleted, () {
      super._secondaryPasswordCompleted = value;
    });
  }

  final _$submitSecondaryPasswordAsyncAction =
      AsyncAction('_PasswordDecryptStore.submitSecondaryPassword');

  @override
  Future<void> submitSecondaryPassword(ProtectedValue secondaryPassword) {
    return _$submitSecondaryPasswordAsyncAction
        .run(() => super.submitSecondaryPassword(secondaryPassword));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
