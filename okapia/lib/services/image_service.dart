import 'dart:io';
import 'dart:typed_data';

import 'package:okapia/common/crypto/credential.dart';
import 'package:okapia/common/crypto/kdf.dart';
import 'package:okapia/common/format/image_data.dart';
import 'package:okapia/common/format/protobuf/data_formats.pb.dart';
import 'package:okapia/common/sqlite/entity/tile_entity.dart';
import 'package:okapia/common/sqlite/repository/image_repository.dart';
import 'package:okapia/common/sqlite/repository/tile_repository.dart';
import 'package:okapia/common/utils/encrypter.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:opencv_helper/opencv_helper.dart';
import 'package:uuid/uuid.dart';

class ImageService {
  final ImageRepository _imageRepository;
  final TileRepository _tileRepository;
  final _uuid = new Uuid();
  final Kdf _kdf;

  ImageService(this._imageRepository, this._tileRepository, this._kdf);

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

  Future<Uint8List> fetchImageData(
      List<String> tileIds, PasswordCredential credential) async {
    final tiles = await _tileRepository.getTiles(tileIds);

    final encryptedBytes =
        Uint8List.fromList(tiles.expand((x) => x.content).toList());
    final encrypter = Encrypter(credential, _kdf);
    final decrypted = await encrypter.decrypt(encryptedBytes);

    return decrypted;
  }

  static const TILE_LENGTH = 1024 * 1024; // 1MB

  List<TileEntity> split(Uint8List bytes) {
    List<TileEntity> tiles = List<TileEntity>();
    final total = (bytes.length / TILE_LENGTH).ceil();
    List<String> ids = List<String>();
    for (int i = 0; i < total; i++) {
      ids.add(_uuid.v4());
    }
    ids.sort();

    for (int i = 0; i < total; i++) {
      int start = i * TILE_LENGTH;
      int end = start + TILE_LENGTH;
      if (end > bytes.length) end = bytes.length;
      tiles.add(TileEntity(id: ids[i], content: bytes.sublist(start, end)));
    }
    return tiles;
  }

  Future<ImageData> createImage(
      String albumId, File file, PasswordCredential credential) async {
    assert(albumId != null);

    Uint8List thumb = await OpencvHelper.resize(file.path, 100, 100);
    final Uint8List bytes =
        await file.readAsBytes().whenComplete(() => file.delete());
    print("image size:${bytes.length}");

    final currentTime = DateTime.now().toIso8601String();

    final ImageMetaMessage metaMessage = ImageMetaMessage.create();
    final ImageDataMessage dataMessage = ImageDataMessage.create();

    metaMessage.createdTime = currentTime;
    metaMessage.lastUpdatedTime = currentTime;
    metaMessage.thumb = thumb;
    metaMessage.title = "";

    final encryptor = Encrypter(credential, _kdf);
    List<TileEntity> tiles = split(await encryptor.encrypt(bytes));
    dataMessage.tiles.addAll(tiles.map((e) => e.id));

    final imageData = ImageData(
        id: _uuid.v4(),
        albumId: albumId,
        meta: metaMessage,
        content: dataMessage);
    final encrypted = await imageData.encrypt(encryptor);

    await _imageRepository.saveImageInTiles(encrypted, tiles);
    return imageData;
  }
}
