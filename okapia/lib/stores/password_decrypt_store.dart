import 'dart:typed_data';

import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'password_decrypt_store.g.dart';

class PasswordDecryptStore = _PasswordDecryptStore with _$PasswordDecryptStore;

abstract class _PasswordDecryptStore with Store {
  final Uint8List _encryptedPassword;
  final UserStore _userStore;
  final PasswordService _service;

  _PasswordDecryptStore(this._encryptedPassword, this._userStore, this._service);

  @observable
  bool _secondaryPasswordVerified = false;

  @observable
  bool _secondaryPasswordCompleted = false;

  bool get secondaryPasswordVerified => _secondaryPasswordVerified;

  bool get secondaryPasswordCompleted => _secondaryPasswordCompleted;

  @action
  Future<void> submitSecondaryPassword(ProtectedValue secondaryPassword) async {
    _secondaryPasswordCompleted = true;
    _secondaryPasswordVerified = false;
  }
}
