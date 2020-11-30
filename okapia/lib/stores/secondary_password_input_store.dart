import 'dart:typed_data';

import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'secondary_password_input_store.g.dart';

class SecondaryPasswordInputStore = _SecondaryPasswordInputStore
    with _$SecondaryPasswordInputStore;

abstract class _SecondaryPasswordInputStore with Store {
  final UserStore _userStore;
  final PasswordService _service;

  _SecondaryPasswordInputStore(this._userStore, this._service);

  @observable
  bool _secondaryPasswordCompleted = false;

  bool get secondaryPasswordCompleted => _secondaryPasswordCompleted;

  @action
  Future<bool> submitSecondaryPassword(ProtectedValue secondaryPassword) async {
    _secondaryPasswordCompleted = true;

    //fixme
    return secondaryPassword == ProtectedValue.of("1234");
  }
}
