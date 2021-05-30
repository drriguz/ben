import 'package:flutter/foundation.dart';
import 'package:okapia/services/initialize_service.dart';
import '../common/crypto/protected_value.dart';

class InitializationState extends ChangeNotifier {
  final InitializeService _service;

  ProtectedValue? _masterPassword;
  ProtectedValue? _secondaryPassword;
  bool _isBusy = false;

  InitializationState(this._service);

  bool get isBusy => _isBusy;

  Future<void> initializeApplication() async {
    assert(_masterPassword != null);
    assert(_secondaryPassword != null);
    _isBusy = true;
    notifyListeners();
    await _service.initialize(_masterPassword!, _secondaryPassword!);
    _isBusy = false;
    notifyListeners();
  }

  void setPassword(
      ProtectedValue masterPassword, ProtectedValue secondaryPassword) {
    _masterPassword = masterPassword;
    _secondaryPassword = secondaryPassword;
  }
}
