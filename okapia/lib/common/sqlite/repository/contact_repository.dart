import 'package:okapia/common/sqlite/entity/contact_entity.dart';
import 'package:okapia/common/sqlite/entity/tile_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_repository.dart';

class ContactRepository extends SqliteRepository<String, ContactEntity> {
  ContactRepository(Database db) : super("contact", "id", db);

  Future<ContactEntity> getById(String id) async {
    final item = await findById(id);
    return item == null ? null : ContactEntity.from(item);
  }

  Future<List<ContactEntity>> getAll() async {
    final items = await db.query(tableName);
    return items.map((e) => ContactEntity.from(e)).toList();
  }

  Future<ContactEntity> getByFingerprint(String fingerprint) async {
    final items = await db.query(
      tableName,
      where: "fingerprint=?",
      whereArgs: [fingerprint],
    );
    return (items == null || items.isEmpty) ? null : ContactEntity.from(items[0]);
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
