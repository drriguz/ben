import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/record/abstract_record.dart';

import 'package:json_annotation/json_annotation.dart';

part 'note_record.g.dart';

@JsonSerializable()
class NoteModel extends AbstractDataRecord implements Serializable {
  final String title;
  final String content;

  NoteModel({String id, DateTime createdTime, DateTime lastUpdatedTime, this.title, this.content})
      : super(
          id,
          createdTime,
          lastUpdatedTime,
        );

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  Map<String, dynamic> get meta {
    return {
      "title": title,
      "createdTime": createdTime?.toIso8601String(),
      "lastUpdatedTime": lastUpdatedTime?.toIso8601String(),
    };
  }
}
