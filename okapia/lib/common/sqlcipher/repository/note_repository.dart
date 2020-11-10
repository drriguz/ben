import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class NoteRepository extends Sqlite3Repository<NoteModel> {
  NoteRepository() : super(NoteModel.TABLE, Entity.FIELDS + NoteModel.FIELDS);

  @override
  NoteModel merge(NoteModel existing, NoteModel updated) {
    existing.title = updated.title;
    existing.content = updated.content;
    return existing;
  }

  @override
  NoteModel convert(Row row) {
    return NoteModel.fromResult(row);
  }
}
