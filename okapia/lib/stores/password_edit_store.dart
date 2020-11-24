import 'package:flutter/material.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/services/event_service.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'password_edit_store.g.dart';

class PasswordEditStore = _PasswordEditStore with _$PasswordEditStore;

abstract class _PasswordEditStore with Store {
  final int _id;
  final PasswordService _service;

  @observable
  bool isSaveAble = false;

  _PasswordEditStore(this._id, this._service);

  @action
  Future<void> create(
      String name, String account, String url, ProtectedValue password) async {
    print("created...");
  }
}
