import 'abstract_data_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteMeta extends StructuredMeta {
  final String title;

  NoteMeta(this.title, DateTime createdTime, DateTime lastUpdatedTime) : super(createdTime, lastUpdatedTime);

  factory NoteMeta.fromJson(Map<String, dynamic> json) => _$NoteMetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteMetaToJson(this);
}

@JsonSerializable()
class NoteData extends StructuredContent<NoteMeta> {
  final String title;
  final String content;

  NoteData(this.title, this.content, DateTime createdTime, DateTime lastUpdatedTime)
      : super(createdTime, lastUpdatedTime);

  factory NoteData.fromJson(Map<String, dynamic> json) => _$NoteDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteDataToJson(this);

  @override
  NoteMeta createMeta() {
    return NoteMeta(title, createdTime, lastUpdatedTime);
  }
}
