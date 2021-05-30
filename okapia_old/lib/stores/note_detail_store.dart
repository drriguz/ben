import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/services/note_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

class NoteDetailStore extends PageStatusNotifier with Store {
  final int _id;
  final UserStore _userStore;
  final NoteService _noteService;

  @observable
  NoteModel? _data;

  NoteDetailStore(this._id, this._userStore, this._noteService);

  @action
  Future<void> fetch() async {
    setBusy();
    await _noteService
        .fetchById(_userStore.database!, _id)
        .then((data) => _data = data)
        .whenComplete(() => setIdle());
  }

  NoteModel? get data => _data;
}
