import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'album_detail_store.g.dart';

class AlbumDetailStore = _AlbumDetailStore with _$AlbumDetailStore;

abstract class _AlbumDetailStore extends PageStatusNotifier with Store {
  final int _id;
  final UserStore _userStore;

  @observable
  AlbumModel _albumData;

  _AlbumDetailStore(this._id, this._userStore);

  @action
  Future<void> fetch() async {
    setBusy();
//    return _albumService
//        .fetch(_id, _userStore.userCredential)
//        .then((data) => _albumData = data)
//        .whenComplete(() => setIdle());
  }

  AlbumModel get data => _albumData;
}
