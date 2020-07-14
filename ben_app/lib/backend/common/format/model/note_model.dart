import 'abstract_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteMetaModel extends AbstractMetaModel {
  final String title;

  NoteMetaModel(this.title, DateTime createdTime, DateTime lastUpdatedTime) : super(createdTime, lastUpdatedTime);

  factory NoteMetaModel.fromJson(Map<String, dynamic> json) => _$NoteMetaModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteMetaModelToJson(this);
}

@JsonSerializable()
class NoteModel extends AbstractContentModel<NoteMetaModel> {
  final String title;
  final String content;

  NoteModel(this.title, this.content, DateTime createdTime, DateTime lastUpdatedTime)
      : super(createdTime, lastUpdatedTime);

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  @override
  NoteMetaModel createMeta() {
    return NoteMetaModel(title, createdTime, lastUpdatedTime);
  }
}
