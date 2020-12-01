import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/common/utils/encrypter.dart';
import 'package:okapia/services/password_service.dart';
import 'package:mobx/mobx.dart';

import 'password_list_store.dart';
import 'user_store.dart';

part 'password_edit_store.g.dart';

class PasswordEditStore = _PasswordEditStore with _$PasswordEditStore;

abstract class _PasswordEditStore with Store {
  final int _id;
  final UserStore _userStore;
  final PasswordListStore _listStore;
  final PasswordService _service;

  @observable
  bool isSaveAble = false;

  @observable
  bool downloading = false;

  @observable
  Uint8List icon;

  _PasswordEditStore(this._id, this._userStore, this._listStore, this._service);

  @action
  Future<void> fetchIcon(String loginUrl) async {
    if (downloading) return;
    downloading = true;
    Uri uri = Uri.parse(loginUrl);
    String favico = "${uri.scheme}://${uri.host}/favicon.ico";
    print("downloading ${favico}");
    return get(favico).then((response) {
      icon = response.bodyBytes;
    }).whenComplete(() => downloading = false);
  }

  @action
  Future<void> create(
      String name,
      String account,
      String url,
      ProtectedValue password,
      Uint8List icon,
      TransformedKey secondaryKey) async {
    final Encrypter encrypter = Encrypter(secondaryKey);
    PasswordModel item = PasswordModel(
      name: name,
      account: account,
      url: url,
      icon: icon,
      content: await encrypter.encrypt(password.binaryValue),
    );
    return _service
        .create(_userStore.database, item)
        .whenComplete(() => _listStore.refresh());
  }
}
