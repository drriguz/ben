import 'abstract_data_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageMeta extends StructuredMeta {
  final String title;
  final String thumb;

  ImageMeta(this.title, this.thumb, DateTime createdTime, DateTime lastUpdatedTime)
      : super(createdTime, lastUpdatedTime);

  factory ImageMeta.fromJson(Map<String, dynamic> json) => _$ImageMetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageMetaToJson(this);
}

@JsonSerializable()
class ImageData extends StructuredContent<ImageMeta> {
  final String title;
  final String thumb;
  final String image;

  ImageData(this.title, this.thumb, this.image, DateTime createdTime, DateTime lastUpdatedTime)
      : super(createdTime, lastUpdatedTime);

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageDataToJson(this);

  @override
  ImageMeta createMeta() {
    return ImageMeta(title, thumb, createdTime, lastUpdatedTime);
  }
}
