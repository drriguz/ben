import 'dart:convert';
import 'dart:typed_data';

import '../data_format.dart';

import 'entity.dart';

class HeaderEntity extends Entity<int> implements Header {
  Uint8List _content;

  Uint8List get content => _content;

  HeaderEntity({int id, Uint8List content})
      : _content = content,
        super(id);

  HeaderEntity.fromHeader(Header header)
      : _content = utf8.encode(header.value),
        super(header.type);

  factory HeaderEntity.from(Map<String, dynamic> values) {
    return HeaderEntity(
      id: values['id'],
      content: values['content'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': _content,
    };
  }

  @override
  int get type => id;

  @override
  String get value => utf8.decode(_content);
}
