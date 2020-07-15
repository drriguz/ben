// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageMeta _$ImageMetaFromJson(Map<String, dynamic> json) {
  return ImageMeta(
    json['title'] as String,
    json['thumb'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$ImageMetaToJson(ImageMeta instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
      'thumb': instance.thumb,
    };

ImageData _$ImageDataFromJson(Map<String, dynamic> json) {
  return ImageData(
    json['title'] as String,
    json['thumb'] as String,
    json['image'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['lastUpdatedTime'] == null
        ? null
        : DateTime.parse(json['lastUpdatedTime'] as String),
  );
}

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'title': instance.title,
      'thumb': instance.thumb,
      'image': instance.image,
    };
