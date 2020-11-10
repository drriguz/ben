import 'package:okapia/common/format/album_data.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';
import 'user_store.dart';

part 'album_store.g.dart';

class AlbumStore = _AlbumStore with _$AlbumStore;

abstract class _AlbumStore extends PageStatusNotifier with Store {
  final UserStore _userStore;

  _AlbumStore(this._userStore);

  @observable
  ObservableList<AlbumData> data = ObservableList<AlbumData>();

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
//    return _albumService
//        .fetchAlbums(_userStore.userCredential)
//        .then((items) => data.addAll(items))
//        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(String name) async {
//    return _albumService
//        .create(_userStore.userCredential, name)
//        .then((value) => data.add(value));
  }

  @action
  Future<void> update(String id, String name) async {
//    final existing = await _albumService.fetch(id, _userStore.userCredential);
//    existing.content.lastUpdatedTime = DateTime.now().toIso8601String();
//    existing.content.name = name;
//
//    return _albumService
//        .update(_userStore.userCredential, existing)
//        .whenComplete(() => fetch());
  }
}
