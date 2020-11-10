import 'package:okapia/common/format/note_data.dart';
import 'package:okapia/common/model/note.dart';
import 'package:okapia/services/item_service.dart';
import 'package:mobx/mobx.dart';
import 'package:okapia/services/note_service.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStore with _$NoteStore;

abstract class _NoteStore<M> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final NoteService _noteService;

  @observable
  ObservableList<NoteModel> data = ObservableList<NoteModel>();

  _NoteStore(this._userStore, this._noteService) {}

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _noteService
        .fetch(_userStore.database)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> update(String id, String content) async {
    setBusy();
    NoteModel existing = data.firstWhere((element) => element.id == id);
    assert(existing != null);

    final String title =
        content.length > 20 ? content.substring(0, 20) : content;
    existing.title = title;
    existing.content = content;

    _noteService
        .update(_userStore.database, existing)
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String content) async {
    setBusy();
    final String title =
        content.length > 20 ? content.substring(0, 20) : content;
    NoteModel note = NoteModel(title: title, content: content);
    _noteService
        .create(_userStore.database, note)
        .then((created) => data.add(created))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(String id) async {
//    return _itemService.delete(id).whenComplete(() {
//      data.removeWhere((element) => element.id == id);
//    });
  }

  @computed
  int get totalCount => data.length;
}
