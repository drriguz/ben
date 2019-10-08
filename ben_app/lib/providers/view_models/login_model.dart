import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/providers/view_models/responding_model.dart';
import 'package:ben_app/service/login_service.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends RespondingModel {
  LoginService loginService;
  Credential _userCredential;

  LoginViewModel()
      : _errorMessage = null,
        _userCredential = null,
        super(State.IDLE);

  String _errorMessage;

  String get errorMessage => _errorMessage;

  Credential get userCredential => _userCredential;

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<bool> login(ProtectedValue masterPassword) async {
    state = State.BUSY;
    bool success = false;
    try {
      final PasswordCredential credential =
          await loginService.checkUserCredential(masterPassword);
      setErrorMessage(null);
      _userCredential = credential;
      success = true;
    } catch (_) {
      setErrorMessage("密码验证失败");
    }
    state = State.IDLE;
    return success;
  }
}
