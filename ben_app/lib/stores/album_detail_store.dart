import 'package:ben_app/common/format/album_data.dart';
import 'package:ben_app/services/album_service.dart';
import 'package:ben_app/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'album_detail_store.g.dart';

class AlbumDetailStore = _AlbumDetailStore with _$AlbumDetailStore;

abstract class _AlbumDetailStore extends PageStatusNotifier with Store {
  final String _id;
  final UserStore _userStore;
  final AlbumService _albumService;

  @observable
  AlbumData _albumData;

  _AlbumDetailStore(this._id, this._userStore, this._albumService);

  @action
  Future<void> fetch() async {
    setBusy();
    return _albumService
        .fetch(_id, _userStore.userCredential)
        .then((data) => _albumData = data)
        .whenComplete(() => setIdle());
  }

  AlbumData get data => _albumData;
}
