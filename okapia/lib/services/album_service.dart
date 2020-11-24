import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/common/sqlcipher/repository/album_repository.dart';

import 'curd_service.dart';

class AlbumService extends CurdService<AlbumModel, AlbumRepository> {
  final AlbumRepository _repository;

  AlbumService(AlbumRepository repository)
      : _repository = repository,
        super(repository);
}
