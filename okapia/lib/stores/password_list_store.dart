import 'package:mobx/mobx.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/data_list_store.dart';

import 'user_store.dart';

part 'password_list_store.g.dart';

class PasswordListStore = _PasswordListStore with _$PasswordListStore;

abstract class _PasswordListStore extends DataListStore<PasswordModel>
    with Store {
  final UserStore _userStore;
  final PasswordService _passwordService;

  _PasswordListStore(this._userStore, this._passwordService);

  @override
  Future<List<PasswordModel>> fetch() async {
    return _passwordService.fetchAll(_userStore.database);
  }

  Future<void> delete(int id) async {
    return _passwordService
        .delete(_userStore.database, id)
        .then((value) => refresh());
  }
}
