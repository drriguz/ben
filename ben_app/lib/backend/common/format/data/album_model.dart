import 'abstract_data_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumMeta extends StructuredMeta {
  final String id;
  final String title;

  AlbumMeta(this.id, this.title, DateTime createdTime, DateTime lastUpdatedTime) : super(createdTime, lastUpdatedTime);

  factory AlbumMeta.fromJson(Map<String, dynamic> json) => _$AlbumMetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumMetaToJson(this);
}

@JsonSerializable()
class AlbumData extends StructuredContent<AlbumMeta> {
  final String id;
  final String title;
  final String cover;

  AlbumData(this.id, this.title, this.cover, DateTime createdTime, DateTime lastUpdatedTime)
      : super(createdTime, lastUpdatedTime);

  factory AlbumData.fromJson(Map<String, dynamic> json) => _$AlbumDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumDataToJson(this);

  @override
  AlbumMeta createMeta() {
    return AlbumMeta(id, title, createdTime, lastUpdatedTime);
  }
}
