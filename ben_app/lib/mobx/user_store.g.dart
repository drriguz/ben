// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError)).value;

  final _$_userCredentialAtom = Atom(name: '_UserStore._userCredential');

  @override
  PasswordCredential get _userCredential {
    _$_userCredentialAtom.context.enforceReadPolicy(_$_userCredentialAtom);
    _$_userCredentialAtom.reportObserved();
    return super._userCredential;
  }

  @override
  set _userCredential(PasswordCredential value) {
    _$_userCredentialAtom.context.conditionallyRunInAction(() {
      super._userCredential = value;
      _$_userCredentialAtom.reportChanged();
    }, _$_userCredentialAtom, name: '${_$_userCredentialAtom.name}_set');
  }

  final _$_errorMessageAtom = Atom(name: '_UserStore._errorMessage');

  @override
  String get _errorMessage {
    _$_errorMessageAtom.context.enforceReadPolicy(_$_errorMessageAtom);
    _$_errorMessageAtom.reportObserved();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String value) {
    _$_errorMessageAtom.context.conditionallyRunInAction(() {
      super._errorMessage = value;
      _$_errorMessageAtom.reportChanged();
    }, _$_errorMessageAtom, name: '${_$_errorMessageAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<bool> login(ProtectedValue masterPassword) {
    return _$loginAsyncAction.run(() => super.login(masterPassword));
  }
}
