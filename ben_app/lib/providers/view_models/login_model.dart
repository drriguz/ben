import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/service/login_service.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  LoginService loginService;
  Credential _userCredential;

  LoginViewModel()
      : _isBusy = false,
        _errorMessage = null,
        _userCredential = null;

  bool _isBusy;
  String _errorMessage;

  bool get isBusy => _isBusy;

  String get errorMessage => _errorMessage;

  Credential get userCredential => _userCredential;

  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<bool> login(ProtectedValue masterPassword) async {
    setBusy(true);
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

    setBusy(false);
    return success;
  }
}
