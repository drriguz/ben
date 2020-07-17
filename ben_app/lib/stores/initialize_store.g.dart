// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InitializeStore on _InitializeStore, Store {
  final _$enableFingerPrintAtom =
      Atom(name: '_InitializeStore.enableFingerPrint');

  @override
  bool get enableFingerPrint {
    _$enableFingerPrintAtom.context.enforceReadPolicy(_$enableFingerPrintAtom);
    _$enableFingerPrintAtom.reportObserved();
    return super.enableFingerPrint;
  }

  @override
  set enableFingerPrint(bool value) {
    _$enableFingerPrintAtom.context.conditionallyRunInAction(() {
      super.enableFingerPrint = value;
      _$enableFingerPrintAtom.reportChanged();
    }, _$enableFingerPrintAtom, name: '${_$enableFingerPrintAtom.name}_set');
  }

  final _$autoDetectEncryptOptionsAtom =
      Atom(name: '_InitializeStore.autoDetectEncryptOptions');

  @override
  bool get autoDetectEncryptOptions {
    _$autoDetectEncryptOptionsAtom.context
        .enforceReadPolicy(_$autoDetectEncryptOptionsAtom);
    _$autoDetectEncryptOptionsAtom.reportObserved();
    return super.autoDetectEncryptOptions;
  }

  @override
  set autoDetectEncryptOptions(bool value) {
    _$autoDetectEncryptOptionsAtom.context.conditionallyRunInAction(() {
      super.autoDetectEncryptOptions = value;
      _$autoDetectEncryptOptionsAtom.reportChanged();
    }, _$autoDetectEncryptOptionsAtom,
        name: '${_$autoDetectEncryptOptionsAtom.name}_set');
  }

  final _$agreeUserAgreementAtom =
      Atom(name: '_InitializeStore.agreeUserAgreement');

  @override
  bool get agreeUserAgreement {
    _$agreeUserAgreementAtom.context
        .enforceReadPolicy(_$agreeUserAgreementAtom);
    _$agreeUserAgreementAtom.reportObserved();
    return super.agreeUserAgreement;
  }

  @override
  set agreeUserAgreement(bool value) {
    _$agreeUserAgreementAtom.context.conditionallyRunInAction(() {
      super.agreeUserAgreement = value;
      _$agreeUserAgreementAtom.reportChanged();
    }, _$agreeUserAgreementAtom, name: '${_$agreeUserAgreementAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_InitializeStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$isSettingsCompletedAtom =
      Atom(name: '_InitializeStore.isSettingsCompleted');

  @override
  bool get isSettingsCompleted {
    _$isSettingsCompletedAtom.context
        .enforceReadPolicy(_$isSettingsCompletedAtom);
    _$isSettingsCompletedAtom.reportObserved();
    return super.isSettingsCompleted;
  }

  @override
  set isSettingsCompleted(bool value) {
    _$isSettingsCompletedAtom.context.conditionallyRunInAction(() {
      super.isSettingsCompleted = value;
      _$isSettingsCompletedAtom.reportChanged();
    }, _$isSettingsCompletedAtom,
        name: '${_$isSettingsCompletedAtom.name}_set');
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

  @override
  void setEnableFingerPrint(bool enabled) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction();
    try {
      return super.setEnableFingerPrint(enabled);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutoDetectEncryptOptions(bool enabled) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction();
    try {
      return super.setAutoDetectEncryptOptions(enabled);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgreeUserAgreement(bool agree) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction();
    try {
      return super.setAgreeUserAgreement(agree);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }
}
