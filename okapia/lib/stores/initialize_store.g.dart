// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InitializeStore on _InitializeStore, Store {
  final _$enableFingerPrintAtom =
      Atom(name: '_InitializeStore.enableFingerPrint');

  @override
  bool get enableFingerPrint {
    _$enableFingerPrintAtom.reportRead();
    return super.enableFingerPrint;
  }

  @override
  set enableFingerPrint(bool value) {
    _$enableFingerPrintAtom.reportWrite(value, super.enableFingerPrint, () {
      super.enableFingerPrint = value;
    });
  }

  final _$agreeUserAgreementAtom =
      Atom(name: '_InitializeStore.agreeUserAgreement');

  @override
  bool get agreeUserAgreement {
    _$agreeUserAgreementAtom.reportRead();
    return super.agreeUserAgreement;
  }

  @override
  set agreeUserAgreement(bool value) {
    _$agreeUserAgreementAtom.reportWrite(value, super.agreeUserAgreement, () {
      super.agreeUserAgreement = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_InitializeStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$isSettingsCompletedAtom =
      Atom(name: '_InitializeStore.isSettingsCompleted');

  @override
  bool get isSettingsCompleted {
    _$isSettingsCompletedAtom.reportRead();
    return super.isSettingsCompleted;
  }

  @override
  set isSettingsCompleted(bool value) {
    _$isSettingsCompletedAtom.reportWrite(value, super.isSettingsCompleted, () {
      super.isSettingsCompleted = value;
    });
  }

  final _$initializeAsyncAction = AsyncAction('_InitializeStore.initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$_InitializeStoreActionController =
      ActionController(name: '_InitializeStore');

  @override
  void setMasterPassword(ProtectedValue password) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction(
        name: '_InitializeStore.setMasterPassword');
    try {
      return super.setMasterPassword(password);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEnableFingerPrint(bool enabled) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction(
        name: '_InitializeStore.setEnableFingerPrint');
    try {
      return super.setEnableFingerPrint(enabled);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgreeUserAgreement(bool agree) {
    final _$actionInfo = _$_InitializeStoreActionController.startAction(
        name: '_InitializeStore.setAgreeUserAgreement');
    try {
      return super.setAgreeUserAgreement(agree);
    } finally {
      _$_InitializeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enableFingerPrint: ${enableFingerPrint},
agreeUserAgreement: ${agreeUserAgreement},
errorMessage: ${errorMessage},
isSettingsCompleted: ${isSettingsCompleted}
    ''';
  }
}
