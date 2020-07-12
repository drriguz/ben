// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderEntity _$HeaderEntityFromJson(Map<String, dynamic> json) {
  return HeaderEntity(
    id: json['id'] as int,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$HeaderEntityToJson(HeaderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };
