import 'dart:typed_data';

import '../data_format.dart';

import 'entity.dart';

class ItemEntity extends Entity<String> implements RawRecord {
  int _type;
  Uint8List _meta;
  Uint8List _content;
  Uint8List _checksum;

  @override
  int get type => _type;

  @override
  Uint8List get meta => _meta;

  @override
  Uint8List get content => _content;

  @override
  Uint8List get checksum => _checksum;

  ItemEntity({String id, int type, Uint8List meta, Uint8List content, Uint8List checksum})
      : _type = type,
        _meta = meta,
        _content = content,
        _checksum = checksum,
        super(id);

  ItemEntity.fromItem(RawRecord item)
      : _type = item.type,
        _meta = item.meta,
        _content = item.content,
        _checksum = item.checksum,
        super(item.id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': _type,
      'meta': _meta,
      'content': _content,
      'checksum': _checksum,
    };
  }

  factory ItemEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return ItemEntity(
      id: values['id'],
      type: values['type'],
      meta: values['meta'],
      content: values['content'],
      checksum: values['checksum'],
    );
  }
}
