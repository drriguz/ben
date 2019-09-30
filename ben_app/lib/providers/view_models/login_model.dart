import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/service/login_service.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService _loginService;

  LoginViewModel(this._loginService)
      : _isBusy = false,
        _errorMessage = null;

  bool _isBusy;
  String _errorMessage;

  bool get isBusy => _isBusy;

  String get errorMessage => _errorMessage;

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
    final bool valid =
        await _loginService.validateMasterPassword(masterPassword);
    setBusy(false);
    setErrorMessage(valid ? null : "密码验证失败");
    return valid;
  }
}
