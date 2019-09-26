import 'package:ben_app/crypto/protected_value.dart';
import 'package:flutter/foundation.dart';

class InitializeViewModel extends ChangeNotifier {
  ProtectedValue _masterPassword;
  ProtectedValue _confirmedMasterPassword;
  String _passwordErrorMessage;
  bool _acceptUserAgreement;
  bool _enableFingerprint;

  InitializeViewModel()
      : _masterPassword = null,
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
    notifyListeners();
    print('hello');
  }

  set confirmedMasterPassword(ProtectedValue value) {
    _confirmedMasterPassword = value;
    notifyListeners();
  }
}