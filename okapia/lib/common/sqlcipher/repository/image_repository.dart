import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/model/image.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class ImageRepository extends Sqlite3Repository<ImageModel> {
  ImageRepository()
      : super(ImageModel.TABLE, Entity.FIELDS + ImageModel.FIELDS);

  @override
  ImageModel merge(ImageModel existing, ImageModel updated) {
    existing.thumb = updated.thumb;
    existing.path = updated.path;
    existing.albumId = updated.albumId;
    return existing;
  }

  @override
  ImageModel convert(Row row) {
    return ImageModel.fromResult(row);
  }
}
