import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/utils/random.dart';

abstract class Entity {
  String id;
  DateTime createdTime;
  DateTime lastUpdatedTime;

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
    Row result = database.query("select count(*) from $table;").first;
    return result.readColumnByIndexAsInt(0);
  }

  Future<List<E>> select(final Database database, String where) async {
    Result result = database.query("select $fields from $table $where;");
    List<E> list = new List<E>();
    for (Row r in result) {
      E item = convert(r);
      list.add(item);
    }
    return list;
  }

  Future<E> selectById(final Database database, String id) async {
    Row r = database
        .query(
          "select $fields from $table where id='${id}';",
        )
        .first;
    return convert(r);
  }

  Future<E> insert(final Database database, final E item) async {
    final String id = IDUtil.generateUUID();
    final DateTime now = DateTime.now();
    item.id = id;
    item.createdTime = now;
    item.lastUpdatedTime = now;
    _executeSql(database, """
    insert into $table($fields)
      values
      ('${item.id}', 
       '${item.createdTime.toIso8601String()}',
       '${item.lastUpdatedTime.toIso8601String()}',
       ${item.toSqlValues()});
    """);
    return item;
  }

  Future<E> update(
      final Database database, final String id, final E updated) async {
    final E existing = await selectById(database, id);
    assert(existing != null);

    E merged = merge(existing, updated);
    final DateTime now = DateTime.now();
    merged.lastUpdatedTime = now;
    _executeSql(database, """
    update $table set last_updated_time='${merged.lastUpdatedTime}', ${merged.toUpdateSql()}
    where id='$id';
    """);
    return merged;
  }

  Future<String> delete(final Database database, String id) async {
    _executeSql(database, """
    delete from $table where id='${id}';
    """);
    return id;
  }

  void _executeSql(final Database database, String sql) {
    print(">\n $sql");
    database.execute(sql);
  }
}
