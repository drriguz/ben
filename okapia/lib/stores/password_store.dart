import 'package:okapia/common/crypto/protected_value.dart';
import 'package:mobx/mobx.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/services/password_service.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'password_store.g.dart';

class PasswordStore = _PasswordStore with _$PasswordStore;

abstract class _PasswordStore<M> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final PasswordService _passwordService;
  int lastId = -1;

  @observable
  ObservableList<PasswordModel> data = ObservableList<PasswordModel>();

  @observable
  bool isLoading = false;

  _PasswordStore(this._userStore, this._passwordService) {}

  @action
  Future<void> refresh() async {
    setBusy();
    data.clear();
    return _passwordService.refresh(_userStore.database).then((items) {
      if (items.isNotEmpty) {
        lastId = items.last.id;
        data.addAll(items);
      }
    }).whenComplete(() => setIdle());
  }

  @action
  Future<void> fetchMore() async {
    isLoading = true;

    return _passwordService.fetch(_userStore.database, lastId).then((items) {
      if (items.isNotEmpty) {
        lastId = items.last.id;
        data.addAll(items);
      }
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> update(int id, String name, String account, String url,
      ProtectedValue password) async {
    setBusy();
    PasswordModel existing = data.firstWhere((element) => element.id == id);
    assert(existing != null);

    existing.name = name;
    existing.account = account;
    existing.url = url;

    _passwordService
        .update(_userStore.database, existing)
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String title, String name, String account, String url,
      ProtectedValue password) async {
    setBusy();
    PasswordModel note = PasswordModel(name: name, account: account, url: url);
    _passwordService
        .create(_userStore.database, note)
        .then((created) => data.insert(0, created))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(int id) async {
    setBusy();
    _passwordService
        .delete(_userStore.database, id)
        .then((id) => data.removeWhere((element) => element.id == id))
        .whenComplete(() => setIdle());
  }

  @computed
  int get totalCount => data.length;
}
