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
  void confirmMasterPassword(
      ProtectedValue password, ProtectedValue confirmPassword) {
    setBusy();
    _masterPassword = null;
    if (password == null || password.getText().length < 5) {
      _passwordErrorMessage = "密码长度不符合要求";
    } else {
      _masterPassword = password;
      _passwordErrorMessage = null;
    }
    setIdle();
  }

  @action
  Future<void> initialize() async {
    assert(_masterPassword != null);
    setBusy();
    await _initializeService.initialize(_masterPassword, _enableFingerprint);
    setIdle();
  }
}
