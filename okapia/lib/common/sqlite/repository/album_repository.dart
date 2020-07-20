import 'package:okapia/common/sqlite/entity/album_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_repository.dart';

class AlbumRepository extends SqliteRepository<String, AlbumEntity> {
  AlbumRepository(Database db) : super("album", "id", db);

  Future<AlbumEntity> getById(String id) async {
    final item = await findById(id);
    return item == null ? null : AlbumEntity.from(item);
  }

  Future<List<AlbumEntity>> getAlbums() async {
    final List<Map<String, dynamic>> results = await db.query(tableName);
    return results.map((values) => AlbumEntity.from(values)).toList();
  }

  Future<int> getAlbumImageCount(String albumId) async {
    final result = await db.rawQuery(
        "select count(*) as count from image where album_id=?", [albumId]);
    return result[0]["count"];
  }
}
