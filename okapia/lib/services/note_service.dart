import '../db/model/note_model.dart';
import '../db/repository/note_repository.dart';

import 'curd_service.dart';

class NoteService extends CurdService<NoteModel, NoteRepository> {
  NoteService(NoteRepository repository) : super(repository);
}
