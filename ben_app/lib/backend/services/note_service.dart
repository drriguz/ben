import '../common/format/data/note_model.dart';

class NoteService {
  NoteData createNote(String content) {
    assert(content != null);

    final lines = content.split("\n");
    final title = lines.firstWhere((line) => line.isNotEmpty);
    final currentTime = DateTime.now();
    return NoteData(
      title,
      content,
      currentTime,
      currentTime,
    );
  }
}
