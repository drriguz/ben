import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/services/album_service.dart';
import 'package:okapia/stores/data_list_store.dart';
import 'package:mobx/mobx.dart';
import 'user_store.dart';

part 'album_store.g.dart';

class AlbumStore = _AlbumStore with _$AlbumStore;

abstract class _AlbumStore extends DataListStore<AlbumModel> with Store {
  final UserStore _userStore;
  final AlbumService _albumService;

  _AlbumStore(this._userStore, this._albumService);

  @override
  Future<List<AlbumModel>> fetch() async {
    return _albumService.fetchAll(_userStore.database!);
  }
}
