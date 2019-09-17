import 'dart:convert';
import 'dart:typed_data';

import '../data_format.dart';

import 'entity.dart';

class HeaderEntity extends Entity<int> implements Header {
  String _content;

  String get content => _content;

  HeaderEntity({int id, String content})
      : _content = content,
        super(id);

  HeaderEntity.fromHeader(Header header)
      : _content = header.value,
        super(header.type);

  factory HeaderEntity.from(Map<String, dynamic> values) {
    assert(values != null);
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
  String get value => _content;
}
