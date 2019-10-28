import 'package:ben_app/backend/services/login_service.dart';
import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore extends PageStatusNotifier with Store {
  final LoginService _loginService;

  @observable
  PasswordCredential _userCredential;

  PasswordCredential get userCredential => _userCredential;

  @observable
  String _errorMessage;

  String get errorMessage => _errorMessage;

  @computed
  bool get hasError => _errorMessage != null;

  _UserStore(this._loginService)
      : _userCredential = null,
        _errorMessage = null,
        super();

  @action
  Future<bool> login(ProtectedValue masterPassword) async {
    setBusy();
    bool success = false;
    try {
      final PasswordCredential credential =
          await _loginService.checkUserCredential(masterPassword);
      _errorMessage = null;
      _userCredential = credential;
      success = true;
    } catch (_) {
      _userCredential = null;
      _errorMessage = "密码验证失败";
    }
    setIdle();
    return success;
  }
}
