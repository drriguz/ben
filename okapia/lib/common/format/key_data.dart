import 'package:okapia/common/sqlite/entity/structured_Item_entity.dart';
import 'package:okapia/common/utils/encrypter.dart';

import 'protobuf/data_formats.pb.dart';

class KeyData {
  String id;
  int type;
  KeyMetaMessage meta;
  KeyDataMessage content;

  KeyData({this.id, this.type, this.meta, this.content});

  Future<StructuredItemEntity> encrypt(Encrypter encrypter) async {
    return StructuredItemEntity(
        id: id,
        type: TYPE_KEY,
        meta: await encrypter.encrypt(meta.writeToBuffer()),
        content: await encrypter.encrypt(content.writeToBuffer()));
  }

  static Future<KeyData> from(StructuredItemEntity entity, Encrypter encrypter) async {
    KeyMetaMessage metaMessage = KeyMetaMessage.fromBuffer(await encrypter.decrypt(entity.meta));
    KeyDataMessage dataMessage = KeyDataMessage.fromBuffer(await encrypter.decrypt(entity.content));
    return KeyData(id: entity.id, meta: metaMessage, content: dataMessage);
  }
}
