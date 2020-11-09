import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/login_service.dart';

import '../common/crypto/credential.dart';
import '../common/crypto/protected_value.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore extends PageStatusNotifier with Store {
  final LoginService _loginService;

  Key _userCredential;

  Key get userCredential => _userCredential;

  bool isPausedToTakePhoto = false;

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
  Future<bool> login(final ProtectedValue masterPassword) async {
    setBusy();
    bool success = false;
    try {
      final Key credential =
          await _loginService.checkUserCredential(masterPassword);
      _errorMessage = null;
      _userCredential = credential;
      success = true;
    } catch (_) {
      print(_);
      _userCredential = null;
      _errorMessage = S.current.password_validation_failed;
    }
    setIdle();
    return success;
  }

  Future<void> logout() async {
    _userCredential = null;
  }
}
