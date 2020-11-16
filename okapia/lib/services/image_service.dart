import 'package:okapia/common/sqlcipher/model/image.dart';
import 'package:okapia/common/sqlcipher/repository/image_repository.dart';

import 'curd_service.dart';

class ImageService extends CurdService<ImageModel, ImageRepository> {
  ImageService(ImageRepository repository) : super(repository);
}
