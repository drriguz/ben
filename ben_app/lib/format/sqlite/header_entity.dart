import 'dart:convert';
import 'dart:typed_data';
import '../data_format.dart';
import 'entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'header_entity.g.dart';

@JsonSerializable()
class HeaderEntity extends Entity<int> implements Header {
  String _content;

  String get content => _content;

  HeaderEntity({int id, String content})
      : _content = content,
        super(id);

  HeaderEntity.fromHeader(Header header)
      : _content = header.value,
        super(header.type);

  factory HeaderEntity.from(Map<String, dynamic> json) => _$HeaderEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HeaderEntityToJson(this);

  @override
  int get type => id;

  @override
  String get value => _content;

  @override
  Uint8List getSources() {
    return utf8.encode("$id:$content");
  }
}
