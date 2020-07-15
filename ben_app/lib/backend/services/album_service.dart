import 'package:ben_app/backend/common/format/data/album_model.dart';
import 'package:uuid/uuid.dart';

class AlbumService {
  final _uuid = new Uuid();

  AlbumData createAlbum(String name) {
    assert(name != null);

    final currentTime = DateTime.now();
    return AlbumData(
      _uuid.v4(),
      name,
      null,
      currentTime,
      currentTime,
    );
  }
}
