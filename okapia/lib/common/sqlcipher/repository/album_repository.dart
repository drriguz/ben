import 'package:native_sqlcipher/native_sqlcipher.dart';
import 'package:okapia/common/sqlcipher/model/album.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class AlbumRepository extends Sqlite3Repository<AlbumModel> {
  AlbumRepository()
      : super(AlbumModel.TABLE, Entity.FIELDS + AlbumModel.FIELDS);

  @override
  AlbumModel merge(AlbumModel existing, AlbumModel updated) {
    existing.name = updated.name;
    existing.coverImageId = updated.coverImageId;
    return existing;
  }

  @override
  AlbumModel convert(Row row) {
    return AlbumModel.fromResult(row);
  }
}
