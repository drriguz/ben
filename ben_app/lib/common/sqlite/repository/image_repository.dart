import 'package:ben_app/common/sqlite/entity/album_entity.dart';
import 'package:ben_app/common/sqlite/entity/image_entity.dart';
import 'package:ben_app/common/sqlite/entity/structured_item_brief_view.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_repository.dart';

class ImageRepository extends SqliteRepository<String, ImageEntity> {
  ImageRepository(Database db) : super("image", "id", db);

  Future<ImageEntity> getById(String id) async {
    final item = await findById(id);
    return item == null ? null : ImageEntity.from(item);
  }

  Future<List<MetaView>> getImages(String albumId) async {
    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      columns: ["id", "meta"],
      where: "album_id=?",
      whereArgs: [albumId],
    );
    return results.map((values) => MetaView.from(values)).toList();
  }
}
