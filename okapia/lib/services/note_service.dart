import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/common/sqlcipher/repository/note_repository.dart';

class NoteService {
  final NoteRepository _noteRepository;

  NoteService(this._noteRepository);

  Future<int> getTotalCount(final Database database) async {
    return _noteRepository.selectCount(database);
  }

  Future<List<NoteModel>> fetch(final Database database) async {
    return _noteRepository.select(database, "order by id desc limit 5");
  }

  Future<NoteModel> fetchById(final Database database, int id) async {
    return _noteRepository.selectById(database, id);
  }

  Future<NoteModel> create(
      final Database database, final NoteModel note) async {
    assert(note.title != null);
    assert(note.content != null);

    return _noteRepository.insert(database, note);
  }

  Future<NoteModel> update(
      final Database database, final NoteModel note) async {
    assert(note.id != null);
    assert(note.createdTime != null);
    assert(note.lastUpdatedTime != null);
    assert(note.title != null);
    assert(note.content != null);

    return _noteRepository.update(database, note.id, note);
  }

  Future<int> delete(final Database database, int id) async {
    return _noteRepository.delete(database, id);
  }
}
