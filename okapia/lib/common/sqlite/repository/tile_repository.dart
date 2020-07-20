import 'package:okapia/common/sqlite/entity/image_entity.dart';
import 'package:okapia/common/sqlite/entity/tile_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_repository.dart';

class TileRepository extends SqliteRepository<String, TileEntity> {
  TileRepository(Database db) : super("image", "id", db);

  Future<ImageEntity> getById(String id) async {
    final item = await findById(id);
    return item == null ? null : ImageEntity.from(item);
  }

  Future<List<TileEntity>> getTiles(List<String> ids) async {
    final paramsPlaceholders = ids.map((e) => '?').toList().join(",");
    final List<Map<String, dynamic>> results = await db.query(
      "tile",
      columns: ["id", "content"],
      where: "id IN ($paramsPlaceholders)",
      whereArgs: ids,
      orderBy: "id",
    );
    return results.map((values) => TileEntity.from(values)).toList();
  }
}
