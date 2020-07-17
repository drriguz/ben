import 'dart:io';
import 'dart:typed_data';

import 'package:ben_app/common/crypto/credential.dart';
import 'package:ben_app/common/crypto/kdf.dart';
import 'package:ben_app/common/format/image_data.dart';
import 'package:ben_app/common/format/protobuf/data_formats.pb.dart';
import 'package:ben_app/common/sqlite/repository/image_repository.dart';
import 'package:ben_app/common/utils/encrypter.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as ImageLib;
import 'package:uuid/uuid.dart';

class ImageService {
  final ImageRepository _imageRepository;
  final _uuid = new Uuid();
  final Kdf _kdf;

  ImageService(this._imageRepository, this._kdf);

  String newId() {
    return _uuid.v4();
  }

  Future<List<BriefImageData>> fetchImages(
      String albumId, PasswordCredential credential) async {
    final items = await _imageRepository.getImages(albumId);
    final encrypter = Encrypter(credential, _kdf);
    final decrypted = items.map((e) => BriefImageData.from(e, encrypter));
    return Future.wait(decrypted);
  }

  Future<ImageData> fetchImage(String id, PasswordCredential credential) async {
    final record = await _imageRepository.getById(id);
    assert(record != null);

    return ImageData.from(record, Encrypter(credential, _kdf));
  }

  static ImageLib.Image generateThumbnail(ImageLib.Image raw) {
    return ImageLib.copyResize(raw, width: 100);
  }

  Future<ImageData> _createImage(String albumId, File file) async {
    final Uint8List bytes =
        await file.readAsBytes().whenComplete(() => file.delete());
    print("image size:${bytes.length}");
    final ImageLib.Image image = await compute(ImageLib.decodeImage, bytes);
    final ImageLib.Image thumbnail = await compute(generateThumbnail, image);
    final currentTime = DateTime.now().toIso8601String();

    final ImageMetaMessage metaMessage = ImageMetaMessage.create();
    final ImageDataMessage dataMessage = ImageDataMessage.create();

    metaMessage.createdTime = currentTime;
    metaMessage.lastUpdatedTime = currentTime;
    metaMessage.thumb = await compute(ImageLib.encodeJpg, thumbnail);
    metaMessage.title = "";

    dataMessage.image = bytes;

    return ImageData(
        id: _uuid.v4(),
        albumId: albumId,
        meta: metaMessage,
        content: dataMessage);
  }

  Future<ImageData> createImage(
      String albumId, File file, PasswordCredential credential) async {
    final image = await _createImage(albumId, file);
    final encrypted = await image.encrypt(Encrypter(credential, _kdf));
    await _imageRepository.insert(encrypted);
    return image;
  }
}
