import 'dart:typed_data';

import '../entity.dart';

const int TYPE_PASSWORD = 1;
const int TYPE_CERTIFICATE = 2;
const int TYPE_NOTE = 3;

class StructuredItemEntity extends Entity<String>
    implements EncryptedMeta, EncryptedData {
  int _type;
  Uint8List _meta;
  Uint8List _content;

  @override
  int get type => _type;

  @override
  Uint8List get meta => _meta;

  @override
  Uint8List get content => _content;

  StructuredItemEntity(
      {String id,
      int type,
      Uint8List meta,
      Uint8List content,
      Uint8List checksum})
      : _type = type,
        _meta = meta,
        _content = content,
        super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': _type,
      'meta': _meta,
      'content': _content,
    };
  }

  factory StructuredItemEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return StructuredItemEntity(
      id: values['id'],
      type: values['type'],
      meta: values['meta'],
      content: values['content'],
    );
  }
}
