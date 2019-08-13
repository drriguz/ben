import 'package:ben_app/entity/tables.dart';

import 'package:sqflite/sqflite.dart';

import 'repository.dart';

class Sqlite3Repository implements AbstractRepository {
  final Future<Database> _databaseInstance;

  const Sqlite3Repository(this._databaseInstance);

  static const String metaTable = "meta_data";
  static const String dataTable = "secret_data";

  @override
  Future<void> createOrUpdateMetaData(MetaDataEntity entity) async {
    final db = await _databaseInstance;
    return await db.insert(
      metaTable,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> createSecretData(SecretDataEntity entity) async {
    final db = await _databaseInstance;
    return await db.insert(
      dataTable,
      entity.toMap(),
    );
  }

  @override
  Future<void> deleteMetaData(MetaDataEntity entity) async {
    final db = await _databaseInstance;
    return await db.delete(
      metaTable,
      where: "id=?",
      whereArgs: [entity.name],
    );
  }

  @override
  Future<void> deleteSecretData(SecretDataEntity entity) async {
    final db = await _databaseInstance;
    return await db.delete(
      dataTable,
      where: "id=?",
      whereArgs: [entity.id],
    );
  }

  @override
  Future<List<MetaDataEntity>> getMetaDatas() async {
    final db = await _databaseInstance;
    final List<Map<String, dynamic>> values = await db.query(metaTable);
    return values.map((values) => MetaDataEntity.from(values)).toList();
  }

  @override
  Future<List<SecretDataEntity>> getSecrets() async {
    final db = await _databaseInstance;
    final List<Map<String, dynamic>> values = await db.query(dataTable);
    return values.map((values) => SecretDataEntity.from(values)).toList();
  }

  @override
  Future<List<SecretDataEntity>> getSecretsByType(DataType type) async {
    final db = await _databaseInstance;
    final List<Map<String, dynamic>> values = await db.query(
      dataTable,
      where: "type=?",
      whereArgs: [type],
    );
    return values.map((values) => SecretDataEntity.from(values)).toList();
  }

  @override
  Future<void> updateSecretData(int id, SecretDataEntity entity) async {
    final db = await _databaseInstance;
    final List<Map<String, dynamic>> values = await db.query(
      metaTable,
      where: "id=?",
      whereArgs: [id],
    );
    return values.map((values) => MetaDataEntity.from(values)).toList();
  }
}
