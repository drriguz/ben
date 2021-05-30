import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/common/sqlcipher/repository/note_repository.dart';

import 'curd_service.dart';

class NoteService extends CurdService<NoteModel, NoteRepository> {
  NoteService(NoteRepository repository) : super(repository);
}
