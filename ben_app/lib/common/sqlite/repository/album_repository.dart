import 'package:ben_app/common/sqlite/entity/album_entity.dart';
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
}
