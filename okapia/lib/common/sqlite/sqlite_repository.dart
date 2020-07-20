import 'package:sqflite/sqflite.dart';

import 'entity.dart';

abstract class SqliteRepository<ID, T extends Entity<ID>> {
  final Database db;
  final String tableName;
  final String idFieldName;

  SqliteRepository(this.tableName, this.idFieldName, this.db);

  Future<void> insert(T entity) async {
    return db.insert(tableName, entity.toJson());
  }

  Future<void> delete(ID id) async {
    return await db.delete(
      tableName,
      where: this.idFieldName + "=?",
      whereArgs: [id],
    );
  }

  Future<void> update(T entity) async {
    assert(entity != null && entity.id != null);

    await db.update(
      tableName,
      entity.toJson(),
      where: _queryById(),
      whereArgs: [entity.id],
    );
  }

  Future<Map<String, dynamic>> findById(ID id) async {
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: _queryById(), whereArgs: [id]);
    if (results.isEmpty) return null;
    return results[0];
  }

  String _queryById() {
    return this.idFieldName + "=?";
  }
}
