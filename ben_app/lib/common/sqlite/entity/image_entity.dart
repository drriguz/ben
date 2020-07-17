import 'dart:typed_data';

import '../entity.dart';

class ImageEntity extends Entity<String>
    implements EncryptedMeta, EncryptedData {
  String albumId;
  Uint8List meta;
  Uint8List content;

  ImageEntity({String id, this.albumId, this.meta, this.content}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'albumId': albumId,
      'meta': meta,
      'content': content,
    };
  }

  factory ImageEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return ImageEntity(
      id: values['id'],
      albumId: values['albumId'],
      meta: values['meta'],
      content: values['content'],
    );
  }
}
