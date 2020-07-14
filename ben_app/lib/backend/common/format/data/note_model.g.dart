// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteMeta _$NoteMetaFromJson(Map<String, dynamic> json) {
  return NoteMeta(
    json['title'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$NoteMetaToJson(NoteMeta instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
    };

NoteData _$NoteDataFromJson(Map<String, dynamic> json) {
  return NoteData(
    json['title'] as String,
    json['content'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$NoteDataToJson(NoteData instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
    };
