import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'password_detail_store.g.dart';

class PasswordDetailStore = _PasswordDetailStore with _$PasswordDetailStore;

abstract class _PasswordDetailStore extends PageStatusNotifier with Store {
  final int _id;
  final UserStore _userStore;
  final PasswordService _service;

  @observable
  PasswordModel _data;

  _PasswordDetailStore(this._id, this._userStore, this._service);

  @action
  Future<void> fetch() async {
    setBusy();
    return _service
        .fetchById(_userStore.database, _id)
        .then((data) => _data = data)
        .whenComplete(() => setIdle());
  }

  PasswordModel get data => _data;
}
