// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InitializeStore on _InitializeStore, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError)).value;

  final _$_masterPasswordAtom = Atom(name: '_InitializeStore._masterPassword');

  @override
  ProtectedValue get _masterPassword {
    _$_masterPasswordAtom.context.enforceReadPolicy(_$_masterPasswordAtom);
    _$_masterPasswordAtom.reportObserved();
    return super._masterPassword;
  }

  @override
  set _masterPassword(ProtectedValue value) {
    _$_masterPasswordAtom.context.conditionallyRunInAction(() {
      super._masterPassword = value;
      _$_masterPasswordAtom.reportChanged();
    }, _$_masterPasswordAtom, name: '${_$_masterPasswordAtom.name}_set');
  }

  final _$_confirmedMasterPasswordAtom =
      Atom(name: '_InitializeStore._confirmedMasterPassword');

  @override
  ProtectedValue get _confirmedMasterPassword {
    _$_confirmedMasterPasswordAtom.context
        .enforceReadPolicy(_$_confirmedMasterPasswordAtom);
    _$_confirmedMasterPasswordAtom.reportObserved();
    return super._confirmedMasterPassword;
  }

  @override
  set _confirmedMasterPassword(ProtectedValue value) {
    _$_confirmedMasterPasswordAtom.context.conditionallyRunInAction(() {
      super._confirmedMasterPassword = value;
      _$_confirmedMasterPasswordAtom.reportChanged();
    }, _$_confirmedMasterPasswordAtom,
        name: '${_$_confirmedMasterPasswordAtom.name}_set');
  }

  final _$_passwordErrorMessageAtom =
      Atom(name: '_InitializeStore._passwordErrorMessage');

  @override
  String get _passwordErrorMessage {
    _$_passwordErrorMessageAtom.context
        .enforceReadPolicy(_$_passwordErrorMessageAtom);
    _$_passwordErrorMessageAtom.reportObserved();
    return super._passwordErrorMessage;
  }

  @override
  set _passwordErrorMessage(String value) {
    _$_passwordErrorMessageAtom.context.conditionallyRunInAction(() {
      super._passwordErrorMessage = value;
      _$_passwordErrorMessageAtom.reportChanged();
    }, _$_passwordErrorMessageAtom,
        name: '${_$_passwordErrorMessageAtom.name}_set');
  }

  final _$_acceptUserAgreementAtom =
      Atom(name: '_InitializeStore._acceptUserAgreement');

  @override
  bool get _acceptUserAgreement {
    _$_acceptUserAgreementAtom.context
        .enforceReadPolicy(_$_acceptUserAgreementAtom);
    _$_acceptUserAgreementAtom.reportObserved();
    return super._acceptUserAgreement;
  }

  @override
  set _acceptUserAgreement(bool value) {
    _$_acceptUserAgreementAtom.context.conditionallyRunInAction(() {
      super._acceptUserAgreement = value;
      _$_acceptUserAgreementAtom.reportChanged();
    }, _$_acceptUserAgreementAtom,
        name: '${_$_acceptUserAgreementAtom.name}_set');
  }

  final _$_enableFingerprintAtom =
      Atom(name: '_InitializeStore._enableFingerprint');

  @override
  bool get _enableFingerprint {
    _$_enableFingerprintAtom.context
        .enforceReadPolicy(_$_enableFingerprintAtom);
    _$_enableFingerprintAtom.reportObserved();
    return super._enableFingerprint;
  }

  @override
  set _enableFingerprint(bool value) {
    _$_enableFingerprintAtom.context.conditionallyRunInAction(() {
      super._enableFingerprint = value;
      _$_enableFingerprintAtom.reportChanged();
    }, _$_enableFingerprintAtom, name: '${_$_enableFingerprintAtom.name}_set');
  }

  final _$initializeAsyncAction = AsyncAction('initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$_InitializeStoreActionController =
      ActionController(name: '_InitializeStore');

  @override
  void setMasterPassword(ProtectedValue password) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction();
    try {
      return super.setMasterPassword(password);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void confirmPassword(ProtectedValue password) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction();
    try {
      return super.confirmPassword(password);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }
}
