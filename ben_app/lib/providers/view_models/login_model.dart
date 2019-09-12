import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel()
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

  Future<bool> login(String masterPassword) async {
    setBusy(true);
    bool valid = masterPassword == "123";
    await Future.delayed(Duration(milliseconds: 500));
    setBusy(false);
    setErrorMessage(valid ? null : "密码验证失败");
    return valid;
  }
}
