// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) {
  return NoteModel(
    id: json['id'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    lastUpdatedTime: json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
    title: json['title'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
    };
