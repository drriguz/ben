import 'package:path/path.dart';

import '../../crypto/protected_value.dart';
import '../../service/init_service.dart';
import 'package:flutter/foundation.dart';

class InitializeViewModel extends ChangeNotifier {
  final InitializeService _initializeService;
  ProtectedValue _masterPassword;
  ProtectedValue _confirmedMasterPassword;
  String _passwordErrorMessage;
  bool _acceptUserAgreement;
  bool _enableFingerprint;

  InitializeViewModel(InitializeService service)
      : _initializeService = service,
        _masterPassword = null,
        _confirmedMasterPassword = null,
        _passwordErrorMessage = null,
        _acceptUserAgreement = false,
        _enableFingerprint = true;

  ProtectedValue get confirmedMasterPassword => _confirmedMasterPassword;

  ProtectedValue get masterPassword => _masterPassword;

  String get passwordErrorMessage => _passwordErrorMessage;

  bool get acceptUserAgreement => _acceptUserAgreement;

  bool get enableFingerprint => _enableFingerprint;

  set enableFingerprint(bool value) {
    _enableFingerprint = value;
    notifyListeners();
  }

  set acceptUserAgreement(bool value) {
    _acceptUserAgreement = value;
    notifyListeners();
  }

  set passwordErrorMessage(String value) {
    _passwordErrorMessage = value;
    notifyListeners();
  }

  set masterPassword(ProtectedValue value) {
    _masterPassword = value;
    if (_masterPassword == null || _masterPassword.getText().length < 5)
      _passwordErrorMessage = "密码长度不符合要求";
    else
      _passwordErrorMessage = null;
    notifyListeners();
  }

  set confirmedMasterPassword(ProtectedValue value) {
    _confirmedMasterPassword = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    print("initializing...");
    return _initializeService.initializeDatabase(
        _masterPassword, _enableFingerprint);
  }
}
