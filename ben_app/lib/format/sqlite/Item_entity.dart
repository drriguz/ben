import 'dart:typed_data';

import '../../format/data_format.dart';

import 'entity.dart';

class ItemEntity extends Entity<String> implements Item {
  int _type;
  Uint8List _content;
  Uint8List _checksum;

  int get type => _type;

  Uint8List get content => _content;

  Uint8List get checksum => _checksum;

  ItemEntity({String id, int type, Uint8List content, Uint8List checksum})
      : _type = type,
        _content = content,
        _checksum = checksum,
        super(id);

  ItemEntity.fromItem(Item item)
      : _type = item.type,
        _content = item.content,
        _checksum = item.checksum,
        super(item.id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': _type,
      'content': _content,
      'checksum': _checksum,
    };
  }

  factory ItemEntity.from(Map<String, dynamic> values) {
    return ItemEntity(
      id: values['id'],
      type: values['type'],
      content: values['content'],
      checksum: values['checksum'],
    );
  }
}
