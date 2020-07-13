import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/format/sqlite/entity.dart';
import 'package:ben_app/format/sqlite/header_entity.dart';
import 'package:ben_app/format/storage.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqliteRepository<ID, T extends Entity<ID>> {
  Database db;
  final String _tableName;
  final String _idFieldName;

  SqliteRepository(this._tableName, this._idFieldName);

  Future<void> insert(T entity) async {
    return db.insert(_tableName, entity.toJson());
  }

  Future<void> delete(ID id) async {
    return await db.delete(
      _tableName,
      where: this._idFieldName + "=?",
      whereArgs: [id],
    );
  }

  Future<void> update(ID id, T entity) async {
    entity.id = id;
    await db.update(
      _tableName,
      entity.toJson(),
      where: _queryById(),
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>> _findById(ID id) async {
    final List<Map<String, dynamic>> results =
        await db.query(_tableName, where: _queryById(), whereArgs: [id]);
    if (results.isEmpty) return null;
    return results[0];
  }

  String _queryById() {
    return this._idFieldName + "=?";
  }
}

class SqliteHeaderRepository extends SqliteRepository<int, HeaderEntity>
    implements HeaderRepository {
  SqliteHeaderRepository()
      : super("meta_data", "id");

  @override
  Future<void> deleteHeader(int type) async {
    return delete(type);
  }

  @override
  Future<Header> getHeader(int type) async {
    final values = await _findById(type);
    return values ?? HeaderEntity.from(values);
  }

  @override
  Future<List<Header>> getHeaders() async {
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((values) => HeaderEntity.from(values)).toList();
  }

  @override
  Future<void> saveHeaders(List<Header> headers) async {
    final batch = db.batch();
    headers.forEach((header) =>
        batch.insert(_tableName, HeaderEntity.fromHeader(header).toJson()));
    await batch.commit();
  }

  @override
  Future<void> updateHeader(Header header) async {
    return update(header.type, HeaderEntity.fromHeader(header));
  }
}

class SqliteItemRepository extends SqliteRepository implements ItemRepository {
  SqliteItemRepository()
      : super("items", "id");

  @override
  Future<void> createItem(RawRecord item) async {
    return insert(ItemEntity.fromItem(item));
  }

  @override
  Future<void> deleteItem(String id) async {
    return delete(id);
  }

  @override
  Future<RawRecord> getById(String id) async {
    final item = await _findById(id);
    return item == null ? null : ItemEntity.from(item);
  }

  @override
  Future<List<RawRecord>> getItems() async {
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((values) => ItemEntity.from(values)).toList();
  }

  @override
  Future<List<RawBriefRecord>> getItemsByType(int type) async {
    final List<Map<String, dynamic>> results = await db.query(
      _tableName,
      columns: ["id", "type", "meta", "checksum"],
      where: "type=?",
      whereArgs: [type],
    );
    return results.map((values) => ItemEntity.from(values)).toList();
  }

  @override
  Future<void> updateItem(String id, RawRecord item) async {
    return update(id, ItemEntity.fromItem(item));
  }
}
