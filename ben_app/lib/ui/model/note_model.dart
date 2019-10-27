import 'package:ben_app/format/serialize.dart';

class NoteModel extends Serializable {
  final String id;
  final String title;
  final String content;

  NoteModel({this.id, this.title, this.content});

  factory NoteModel.fromMap(Map map) {
    assert(map != null);
    return NoteModel(
      id: map["id"],
      title: map["title"],
      content: map["content"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
    };
  }
}
