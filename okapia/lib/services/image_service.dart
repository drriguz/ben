import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/image.dart';
import 'package:okapia/common/sqlcipher/repository/image_repository.dart';

import 'curd_service.dart';

class ImageService extends CurdService<ImageModel, ImageRepository> {
  final ImageRepository _imageRepository;

  ImageService(ImageRepository repository)
      : _imageRepository = repository,
        super(repository);

  Future<List<ImageModel>> fetchByAlbum(
      final Database database, int albumId, int lastId) async {
    String where = lastId < 0 ? "" : "where album_id=$albumId and id < $lastId";
    return _imageRepository.select(
        database, "$where order by id desc limit 20");
  }
}
