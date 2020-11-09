import 'package:okapia/common/format/note_data.dart';
import 'package:okapia/services/item_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

class NoteDetailStore extends PageStatusNotifier with Store {
  final String _id;
  final UserStore _userStore;
  final ItemService _itemService;

  @observable
  NoteData _noteData;

  NoteDetailStore(this._id, this._userStore, this._itemService);

  @action
  Future<void> fetch() async {
    setBusy();
//    return _itemService
//        .fetchNote(_id, _userStore.userCredential)
//        .then((data) => _noteData = data)
//        .whenComplete(() => setIdle());
  }

  NoteData get data => _noteData;
}
