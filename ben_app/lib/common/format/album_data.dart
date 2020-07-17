import 'package:ben_app/common/crypto/credential.dart';
import 'package:ben_app/common/sqlite/entity/album_entity.dart';
import 'package:ben_app/common/utils/encrypter.dart';

import 'protobuf/data_formats.pb.dart';

class AlbumData {
  String id;
  AlbumMessage content;

  AlbumData({this.id, this.content});

  Future<AlbumEntity> encrypt(Encrypter encrypter) async {
    return AlbumEntity(
        id: id, content: await encrypter.encrypt(content.writeToBuffer()));
  }

  static Future<AlbumData> from(AlbumEntity entity, Encrypter encrypter) async {
    AlbumMessage content =
        AlbumMessage.fromBuffer(await encrypter.decrypt(entity.content));
    return AlbumData(id: entity.id, content: content);
  }
}
