import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';

import '../entity/structured_item_brief_view.dart';
import '../entity/structured_Item_entity.dart';
import '../sqlite_repository.dart';

class StructuredItemRepository extends SqliteRepository<String, StructuredItemEntity> {
  StructuredItemRepository(Database db) : super("structured_item", "id", db);

  Future<StructuredItemEntity> getByIdAndType(String id, int type) async {
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: "id=? and type=?", whereArgs: [id, type]);
    return results.isEmpty ? null : StructuredItemEntity.from(results[0]);
  }

  Future<List<StructuredItemEntity>> getItems() async {
    final List<Map<String, dynamic>> results = await db.query(tableName);
    return results.map((values) => StructuredItemEntity.from(values)).toList();
  }

  Future<List<MetaView>> getItemsByType(int type) async {
    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      columns: ["id", "meta"],
      where: "type=?",
      whereArgs: [type],
    );
    final List<MetaView> items = results.map((values) => MetaView.from(values)).toList();
    return items;
  }

  Future<List<StructuredItemEntity>> getFullItemsByType(int type) async {
    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: "type=?",
      whereArgs: [type],
    );
    return results.map((values) => StructuredItemEntity.from(values)).toList();
  }
}
