// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secondary_password_input_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SecondaryPasswordInputStore on _SecondaryPasswordInputStore, Store {
  final _$_errorAtom = Atom(name: '_SecondaryPasswordInputStore._error');

  @override
  String get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(String value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  final _$submitSecondaryPasswordAsyncAction =
      AsyncAction('_SecondaryPasswordInputStore.submitSecondaryPassword');

  @override
  Future<bool> submitSecondaryPassword(ProtectedValue secondaryPassword) {
    return _$submitSecondaryPasswordAsyncAction
        .run(() => super.submitSecondaryPassword(secondaryPassword));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
