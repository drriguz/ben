import 'dart:typed_data';

import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/login_service.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'secondary_password_input_store.g.dart';

class SecondaryPasswordInputStore = _SecondaryPasswordInputStore
    with _$SecondaryPasswordInputStore;

abstract class _SecondaryPasswordInputStore with Store {
  final LoginService _loginService;

  _SecondaryPasswordInputStore(this._loginService);

  @observable
  String _error;

  @observable
  bool _isChecking = false;

  bool get isChecking => _isChecking;

  String get error => _error;

  @action
  Future<bool> submitSecondaryPassword(ProtectedValue secondaryPassword) async {
    _isChecking = true;
    try {
      Key secondaryKey =
          await _loginService.checkSecondaryPassword(secondaryPassword);
      return true;
    } catch (_) {
      _error = S.current.password_validation_failed;
      return false;
    } finally {
      _isChecking = false;
    }
  }
}
