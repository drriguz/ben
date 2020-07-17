import 'package:ben_app/common/format/album_data.dart';
import 'package:ben_app/services/album_service.dart';
import 'package:ben_app/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';
import 'user_store.dart';

part 'album_store.g.dart';

class AlbumStore = _AlbumStore with _$AlbumStore;

abstract class _AlbumStore extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final AlbumService _albumService;

  _AlbumStore(this._userStore, this._albumService);

  @observable
  ObservableList<AlbumData> data = ObservableList<AlbumData>();

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _albumService
        .fetchAlbums(_userStore.userCredential)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String name) async {
    return _albumService
        .create(_userStore.userCredential, name)
        .then((value) => data.add(value));
  }
}
