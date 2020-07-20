import 'dart:typed_data';

import '../entity.dart';

class AlbumEntity extends Entity<String> implements EncryptedData {
  Uint8List content;

  AlbumEntity({String id, this.content}) : super(id);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
      };

  factory AlbumEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return AlbumEntity(
      id: values['id'],
      content: values['content'],
    );
  }
}
