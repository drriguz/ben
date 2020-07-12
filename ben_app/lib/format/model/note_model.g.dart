// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteMetaModel _$NoteMetaModelFromJson(Map<String, dynamic> json) {
  return NoteMetaModel(
    json['title'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$NoteMetaModelToJson(NoteMetaModel instance) =>
    <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
    };

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) {
  return NoteModel(
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

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
    };
