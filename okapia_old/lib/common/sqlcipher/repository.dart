import 'package:native_sqlcipher/native_sqlcipher.dart';

abstract class Entity {
  int? id;
  int? createdTime;
  int? lastUpdatedTime;

  static final String FIELDS = "id, created_time, last_updated_time,";

  Entity(this.id, this.createdTime, this.lastUpdatedTime);

  String toSqlValues();

  String toUpdateSql();
}

abstract class Sqlite3Repository<E extends Entity> {
  final String table;
  final String fields;

  Sqlite3Repository(this.table, this.fields);

  E convert(final Row row);

  E merge(final E existing, final E updated);

  Future<int> selectCount(final Database database) async {
    Result result = database.query("select count(*) from $table;");
    try {
      return result.first.readColumnByIndexAsInt(0);
    } finally {
      result.close();
    }
  }

  Future<List<E>> select(final Database database, String where) async {
    Result result = database.query("select $fields from $table $where;");

    try {
      List<E> list = [];
      for (Row r in result) {
        E item = convert(r);
        list.add(item);
      }
      return list;
    } finally {
      result.close();
    }
  }

  Future<E> selectById(final Database database, int id) async {
    Result result = database.query(
      "select $fields from $table where id='$id';",
    );
    try {
      return convert(result.first);
    } finally {
      result.close();
    }
  }

  Future<E> insert(final Database database, final E item) async {
    final int now = DateTime.now().millisecondsSinceEpoch;
    item.createdTime = now;
    item.lastUpdatedTime = now;
    _executeSql(database, """
    insert into $table($fields)
      values
      (null, 
       ${item.createdTime},
       ${item.lastUpdatedTime},
       ${item.toSqlValues()});
    """);
    int id = database.lastInsertRowid();
    item.id = id;
    return item;
  }

  Future<E> update(
      final Database database, final int id, final E updated) async {
    final E? existing = await selectById(database, id);
    assert(existing != null);

    E merged = merge(existing!, updated);
    merged.lastUpdatedTime = DateTime.now().millisecondsSinceEpoch;
    _executeSql(database, """
    update $table set last_updated_time=${merged.lastUpdatedTime}, ${merged.toUpdateSql()}
    where id=$id;
    """);
    return merged;
  }

  Future<int> delete(final Database database, int id) async {
    _executeSql(database, """
    delete from $table where id=$id;
    """);
    return id;
  }

  void _executeSql(final Database database, String sql) {
    print(">\n $sql");
    database.execute(sql);
  }
}
