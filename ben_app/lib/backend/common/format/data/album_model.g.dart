// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumMeta _$AlbumMetaFromJson(Map<String, dynamic> json) {
  return AlbumMeta(
    json['id'] as String,
    json['title'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$AlbumMetaToJson(AlbumMeta instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'id': instance.id,
      'title': instance.title,
    };

AlbumData _$AlbumDataFromJson(Map<String, dynamic> json) {
  return AlbumData(
    json['id'] as String,
    json['title'] as String,
    json['cover'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$AlbumDataToJson(AlbumData instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
    };
