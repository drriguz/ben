import 'dart:convert';
import 'dart:typed_data';

import '../entity.dart';

class HeaderEntity extends Entity<int> {
  String content;

  HeaderEntity({int id, this.content}) : super(id);

  factory HeaderEntity.from(Map<String, dynamic> json) {
    assert(json != null);
    return HeaderEntity(
      id: json["id"],
      content: json["content"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
      };

  @override
  Uint8List getSources() {
    return utf8.encode("$id:$content");
  }
}
