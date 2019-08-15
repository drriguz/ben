import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlite3_repository.dart';

class RepositoryFactory {
  static const _fileName = "ben.dat";

  static Future<Sqlite3Repository> createInstance() async {
    final String dbPath = join(await getDatabasesPath(), _fileName);
    print("Opening database:${dbPath}");
    final Future<Database> database = openDatabase(
      dbPath,
      onCreate: _initialize,
      version: 1,
    );
    return new Sqlite3Repository(database);
  }

  static Future<bool> _initialize(Database db, int version) async {
    final String script = await rootBundle.loadString("assets/config/init.sql");
    final batch = db.batch();
    for (final statement in script.split(";")) {
      final sql = statement.trim();
      if (sql.isNotEmpty) {
        print("Executing:" + sql);
        batch.execute(sql);
      }
    }
    await batch.commit(noResult: true);
  }
}
