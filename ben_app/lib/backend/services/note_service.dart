import 'package:ben_app/ui/model/note_model.dart';

class NoteService {
  NoteModel buildNote(String content) {
    assert(content != null);

    final lines = content.trim().split("\n");
    final title = lines.length > 0 ? lines[0] : "(无内容)";
    return NoteModel(
      title: title,
      content: content,
    );
  }
}
