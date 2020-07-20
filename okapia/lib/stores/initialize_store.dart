import '../services/init_service.dart';
import '../common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'initialize_store.g.dart';

class InitializeStore = _InitializeStore with _$InitializeStore;

abstract class _InitializeStore extends PageStatusNotifier with Store {
  final InitializeService _initializeService;

  ProtectedValue _masterPassword;

  ProtectedValue _confirmedMasterPassword;

  @observable
  bool enableFingerPrint;

  @observable
  bool autoDetectEncryptOptions;

  @observable
  bool agreeUserAgreement;

  @observable
  String errorMessage;

  @observable
  bool isSettingsCompleted;

  _InitializeStore(this._initializeService)
      : _masterPassword = null,
        _confirmedMasterPassword = null,
        errorMessage = null,
        enableFingerPrint = false,
        autoDetectEncryptOptions = false,
        agreeUserAgreement = false,
        isSettingsCompleted = false;

  @action
  void setMasterPassword(ProtectedValue password) {
    setBusy();
    _masterPassword = password;
    _validatePassword();
    setIdle();
  }

  @action
  void confirmPassword(ProtectedValue password) {
    setBusy();
    _confirmedMasterPassword = password;
    _validatePassword();
    setIdle();
  }

  @action
  void setEnableFingerPrint(bool enabled) {
    enableFingerPrint = enabled;
  }

  @action
  void setAutoDetectEncryptOptions(bool enabled) {
    autoDetectEncryptOptions = enabled;
  }

  @action
  void setAgreeUserAgreement(bool agree) {
    agreeUserAgreement = agree;
  }

  void _validatePassword() {
    if (_masterPassword == null || _masterPassword.getText().length < 6) {
      errorMessage = S.current.password_too_short;
      isSettingsCompleted = false;
    } else if (_masterPassword != _confirmedMasterPassword) {
      errorMessage = S.current.password_does_not_match;
      isSettingsCompleted = false;
    } else {
      errorMessage = null;
      isSettingsCompleted = true;
    }
    print(errorMessage);
  }

  @action
  Future<void> initialize() async {
    assert(_masterPassword != null);
    assert(agreeUserAgreement);
    setBusy();
    await _initializeService.initialize(_masterPassword, enableFingerPrint);
    setIdle();
  }
}
