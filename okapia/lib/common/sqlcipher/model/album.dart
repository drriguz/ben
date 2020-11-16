import 'package:native_sqlcipher/database.dart';

import '../repository.dart';

class AlbumModel extends Entity {
  String name;
  int coverImageId;

  static final String TABLE = "album";
  static final String FIELDS = "name, cover_image_id";

  AlbumModel(
      {int id,
      this.name,
      this.coverImageId,
      int createdTime,
      int lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static AlbumModel fromResult(Row r) {
    return AlbumModel(
      id: r.readColumnAsInt("id"),
      name: r.readColumnAsText("name"),
      coverImageId: r.readColumnAsInt("cover_image_id"),
      createdTime: r.readColumnAsInt64("created_time"),
      lastUpdatedTime: r.readColumnAsInt64("last_updated_time"),
    );
  }

  @override
  String toSqlValues() {
    return "'$name', $coverImageId";
  }

  @override
  String toUpdateSql() {
    return "name='$name', cover_image_id=$coverImageId";
  }
}
