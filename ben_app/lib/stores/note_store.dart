import 'package:ben_app/common/format/note_data.dart';
import 'package:ben_app/services/item_service.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStore with _$NoteStore;

abstract class _NoteStore<M> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final ItemService _itemService;

  @observable
  ObservableList<BriefNoteData> data = ObservableList<BriefNoteData>();

  _NoteStore(this._userStore, this._itemService) {}

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _itemService
        .fetchNotes(_userStore.userCredential)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> update(String id, String content) async {
    return _itemService
        .updateNote(id, content, _userStore.userCredential)
        .then((updated) async {
      final index = data.indexWhere((element) => element.id == id);
      assert(index != -1);
      data[index].meta = updated.meta;
    }).whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String content) async {
    return _itemService
        .createNote(content, _userStore.userCredential)
        .then((note) async =>
            data.add(BriefNoteData(id: note.id, meta: note.meta)))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(String id) async {
    return _itemService.delete(id).whenComplete(() {
      data.removeWhere((element) => element.id == id);
    });
  }

  @computed
  int get totalCount => data.length;
}
