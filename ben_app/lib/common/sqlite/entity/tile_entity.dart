import 'dart:typed_data';

import '../entity.dart';

class TileEntity extends Entity<String> {
  Uint8List content;

  TileEntity({String id, this.content}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
    };
  }

  factory TileEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return TileEntity(
      id: values['id'],
      content: values['content'],
    );
  }
}
