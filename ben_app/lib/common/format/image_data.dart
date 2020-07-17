import 'dart:typed_data';

import 'package:ben_app/common/sqlite/entity/image_entity.dart';
import 'package:ben_app/common/sqlite/entity/structured_item_brief_view.dart';
import 'package:ben_app/common/utils/encrypter.dart';

import 'protobuf/data_formats.pb.dart';

class ImageData {
  String id;
  String albumId;
  ImageMetaMessage meta;
  ImageDataMessage content;

  ImageData({this.id, this.albumId, this.meta, this.content});

  Future<ImageEntity> encrypt(Encrypter encrypter) async {
    return ImageEntity(
        id: id,
        meta: await encrypter.encrypt(meta.writeToBuffer()),
        content: await encrypter.encrypt(content.writeToBuffer()));
  }

  static Future<ImageData> from(ImageEntity entity, Encrypter encrypter) async {
    ImageMetaMessage metaMessage =
        ImageMetaMessage.fromBuffer(await encrypter.decrypt(entity.meta));
    ImageDataMessage dataMessage =
        ImageDataMessage.fromBuffer(await encrypter.decrypt(entity.content));
    return ImageData(id: entity.id, meta: metaMessage, content: dataMessage);
  }
}

class BriefImageData {
  String id;
  ImageMetaMessage meta;

  BriefImageData({this.id, this.meta});

  static Future<BriefImageData> from(MetaView view, Encrypter encrypter) async {
    ImageMetaMessage metaMessage =
        ImageMetaMessage.fromBuffer(await encrypter.decrypt(view.meta));
    return BriefImageData(id: view.id, meta: metaMessage);
  }

  factory BriefImageData.fromFullRecord(ImageData data) {
    return BriefImageData(id: data.id, meta: data.meta);
  }
}
