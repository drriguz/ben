import 'package:okapia/common/format/album_data.dart';
import 'package:okapia/common/sqlite/entity/contact_entity.dart';
import 'package:okapia/common/sqlite/repository/contact_repository.dart';
import 'package:okapia/services/album_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore extends PageStatusNotifier with Store {
  final String _id;
  final UserStore _userStore;
  final ContactRepository _contactRepository;

  @observable
  ContactEntity contact;

  _ChatStore(this._id, this._userStore, this._contactRepository);

  @action
  Future<void> fetch() async {
    setBusy();
    return _contactRepository.getById(_id).then((data) => contact = data).whenComplete(() => setIdle());
  }
}
