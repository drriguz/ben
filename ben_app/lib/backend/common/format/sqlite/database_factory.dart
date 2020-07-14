import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteFactory {
  static Future<Database> createInstance(
      String fileName, String initSql) async {
    final String dbPath = join(await getDatabasesPath(), fileName);
    print("Opening database:$dbPath");
    return openDatabase(
      dbPath,
      onCreate: (db, version) => _initialize(db, version, initSql),
      version: 1,
    );
  }

  static Future<void> _initialize(
      Database db, int version, String initSql) async {
    final String script = await rootBundle.loadString(initSql);
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
