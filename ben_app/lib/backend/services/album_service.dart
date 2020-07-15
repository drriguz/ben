import 'dart:convert';
import 'dart:io';

import 'package:ben_app/backend/common/format/data/album_model.dart';
import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';

class AlbumService {
  final _uuid = new Uuid();

  AlbumData createAlbum(String name) {
    assert(name != null);

    final currentTime = DateTime.now();
    return AlbumData(
      _uuid.v4(),
      name,
      null,
      currentTime,
      currentTime,
    );
  }

  Future<ImageData> createImage(String albumId, File file) async {
    final Image image = decodeImage(file.readAsBytesSync());
    await file.delete();
    final Image thumbnail = copyResize(image, width: 100);
    final currentTime = DateTime.now();
    return ImageData(
      "image",
      base64.encode(encodeJpg(thumbnail)),
      base64.encode(encodeJpg(image)),
      currentTime,
      currentTime,
    );
  }
}
