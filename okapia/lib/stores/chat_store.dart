import 'package:okapia/common/sqlite/entity/contact_entity.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore extends PageStatusNotifier with Store {
  final String _id;
  final UserStore _userStore;

  @observable
  ContactEntity contact;

  _ChatStore(this._id, this._userStore);

  @action
  Future<void> fetch() async {
    setBusy();
  }
}
