import 'package:ben_app/ui/model/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  final _uuid = Uuid();

  NoteModel createNote(String content) {
    assert(content != null);

    final lines = content.trim().split("\n");
    final title = lines.length > 0 ? lines[0] : "(无内容)";
    final currentTime = DateTime.now();
    return NoteModel(
      id: _uuid.v4(),
      createdTime: currentTime,
      lastUpdatedTime: currentTime,
      title: title,
      content: content,
    );
  }
}
