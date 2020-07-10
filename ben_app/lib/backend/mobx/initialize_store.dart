import 'package:ben_app/backend/services/init_service.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'initialize_store.g.dart';

class InitializeStore = _InitializeStore with _$InitializeStore;

abstract class _InitializeStore extends PageStatusNotifier with Store {
  final InitializeService _initializeService;

  @observable
  ProtectedValue _masterPassword;

  @observable
  ProtectedValue _confirmedMasterPassword;

  @observable
  String _passwordErrorMessage;

  String get passwordErrorMessage => _passwordErrorMessage;

  @computed
  bool get hasError => _passwordErrorMessage != null;

  @observable
  bool _acceptUserAgreement;

  @observable
  bool _enableFingerprint;

  _InitializeStore(this._initializeService)
      : _masterPassword = null,
        _passwordErrorMessage = null,
        _acceptUserAgreement = false,
        _enableFingerprint = true;

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

  void _validatePassword() {
    if (_masterPassword == null || _masterPassword.getText().length < 6) {
      _passwordErrorMessage = "密码长度不符合要求";
    } else if (_masterPassword != _confirmedMasterPassword) {
      _passwordErrorMessage = "两次输入的密码不一致";
    } else {
      _passwordErrorMessage = null;
    }
  }

  @action
  Future<void> initialize() async {
    assert(_masterPassword != null);
    setBusy();
    await _initializeService.initialize(_masterPassword, _enableFingerprint);
    setIdle();
  }
}
