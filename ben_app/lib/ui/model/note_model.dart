import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/ui/model/abstract_model.dart';

class NoteModel extends AbstractModel implements Serializable {
  final String title;
  final String content;

  NoteModel(
      {String id,
      DateTime createdTime,
      DateTime lastUpdatedTime,
      this.title,
      this.content})
      : super(
          id: id,
          createdTime: createdTime,
          lastUpdatedTime: lastUpdatedTime,
        );

  factory NoteModel.fromMap(Map map) {
    assert(map != null);
    return NoteModel(
      id: map["id"],
      title: map["title"],
      content: map["content"],
      createdTime: map["createdTime"],
      lastUpdatedTime: map["lastUpdatedTime"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "createdTime": createdTime,
      "lastUpdatedTime": lastUpdatedTime,
    };
  }
}
