import 'package:native_sqlcipher/database.dart';

import '../repository.dart';

class ImageModel extends Entity {
  String thumb;
  String path;
  int albumId;

  static final String TABLE = "image";
  static final String FIELDS = "thumb, path, album_id";

  ImageModel(
      {int id,
      this.thumb,
      this.path,
      this.albumId,
      int createdTime,
      int lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static ImageModel fromResult(Row r) {
    return ImageModel(
      id: r.readColumnAsInt("id"),
      thumb: r.readColumnAsText("thumb"),
      path: r.readColumnAsText("path"),
      albumId: r.readColumnAsInt("album_id"),
      createdTime: r.readColumnAsInt64("created_time"),
      lastUpdatedTime: r.readColumnAsInt64("last_updated_time"),
    );
  }

  @override
  String toSqlValues() {
    return "'$thumb', '$path', $albumId";
  }

  @override
  String toUpdateSql() {
    return "thumb='$thumb', path='$path', album_id=$albumId";
  }
}
