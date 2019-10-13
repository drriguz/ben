import 'package:ben_app/plugins/abstract_plugin.dart';

class NoteModel extends DataModel {
  final String title;
  final String content;

  NoteModel({String id, this.title, this.content}) : super(id);

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
