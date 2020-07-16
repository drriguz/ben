import 'dart:convert';
import 'dart:io';

import 'package:ben_app/backend/common/format/data/album_model.dart';
import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:flutter/foundation.dart';
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

  String newId() {
    return _uuid.v4();
  }

  static Image generateThumbnail(Image raw) {
    return copyResize(raw, width: 100);
  }

  Future<ImageData> createImage(String albumId, File file) async {
    final List<int> bytes =
        await file.readAsBytes().whenComplete(() => file.delete());
    final Image image = await compute(decodeImage, bytes);
    final Image thumbnail = await compute(generateThumbnail, image);
    final currentTime = DateTime.now();
    return ImageData(
      "image",
      base64.encode(await compute(encodeJpg, thumbnail)),
      base64.encode(await compute(encodeJpg, image)),
      currentTime,
      currentTime,
    );
  }
}
