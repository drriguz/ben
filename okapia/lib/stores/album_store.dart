import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/services/album_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';
import 'user_store.dart';

part 'album_store.g.dart';

class AlbumStore = _AlbumStore with _$AlbumStore;

abstract class _AlbumStore extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final AlbumService _albumService;

  _AlbumStore(this._userStore, this._albumService);

  @observable
  ObservableList<AlbumModel> data = ObservableList<AlbumModel>();

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _albumService
        .fetchAll(_userStore.database)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String name) async {
    AlbumModel item = AlbumModel(name: name);
    return _albumService
        .create(_userStore.database, item)
        .then((value) => data.add(value));
  }

  @action
  Future<void> update(int id, String name) async {
    setBusy();
    AlbumModel existing = data.firstWhere((element) => element.id == id);
    assert(existing != null);

    existing.name = name;

    _albumService
        .update(_userStore.database, existing)
        .whenComplete(() => setIdle());
  }
}
