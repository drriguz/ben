import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

abstract class CurdService<M extends Entity, R extends Sqlite3Repository<M>> {
  final R _repository;

  CurdService(this._repository);

  Future<int> getTotalCount(final Database database) async {
    return _repository.selectCount(database);
  }

  Future<List<M>> fetch(final Database database, int lastId) async {
    String where = lastId < 0 ? "" : "where id < $lastId";
    return _repository.select(database, "$where order by id desc limit 20");
  }

  Future<List<M>> refresh(final Database database) async {
    return _repository.select(database, "order by id desc limit 20");
  }

  Future<M> fetchById(final Database database, int id) async {
    return _repository.selectById(database, id);
  }

  Future<M> create(final Database database, final M note) async {
    return _repository.insert(database, note);
  }

  Future<M> update(final Database database, final M note) async {
    assert(note.id != null);
    assert(note.createdTime != null);
    assert(note.lastUpdatedTime != null);

    return _repository.update(database, note.id, note);
  }

  Future<int> delete(final Database database, int id) async {
    return _repository.delete(database, id);
  }
}
