import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:mobx/mobx.dart';
import 'package:okapia/services/note_service.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStore with _$NoteStore;

abstract class _NoteStore<M> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final NoteService _noteService;
  int lastId = -1;

  @observable
  ObservableList<NoteModel> data = ObservableList<NoteModel>();

  @observable
  bool isLoading = false;

  _NoteStore(this._userStore, this._noteService) {}

  @action
  Future<void> refresh() async {
    setBusy();
    data.clear();
    return _noteService
        .refresh(_userStore.database)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> fetchMore() async {
    isLoading = true;

    return _noteService.fetch(_userStore.database, lastId).then((items) {
      if (items.isNotEmpty) {
        lastId = items.last.id;
        data.addAll(items);
      }
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> update(int id, String content) async {
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
        .then((created) => data.insert(0, created))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(int id) async {
    setBusy();
    _noteService
        .delete(_userStore.database, id)
        .then((id) => data.removeWhere((element) => element.id == id))
        .whenComplete(() => setIdle());
  }

  @computed
  int get totalCount => data.length;
}
