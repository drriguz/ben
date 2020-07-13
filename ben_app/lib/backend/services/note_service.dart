import 'package:ben_app/format/model/note_model.dart';

class NoteService {
  NoteModel createNote(String content) {
    assert(content != null);

    final lines = content.split("\n");
    final title = lines.firstWhere((line) => line.isNotEmpty);
    final currentTime = DateTime.now();
    return NoteModel(
      title,
      content,
      currentTime,
      currentTime,
    );
  }
}
