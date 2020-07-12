import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/format/storage.dart';
import 'package:ben_app/format/record/abstract_record.dart';
import 'package:encryptions/encryptions.dart';
import 'package:uuid/uuid.dart';

class ItemService {
  final ItemRepository _itemRepository;
  final Kdf _kdf;

  final _uuid = new Uuid();

  ItemService(this._itemRepository, this._kdf);

  Future<List<PreviewAble>> fetchByType(int type) async {
    return _itemRepository.getItemsByType(type);
  }

  Future<void> create<T extends AbstractDataRecord>(int type, T data, PasswordCredential credential) async {
    final contentBytes = Serializer.toJson(data);
    final metaBytes = Serializer.toJsonRaw(data.meta);
    final AES aes =
        AES.ofCBC(await credential.getEncryptionKey(_kdf), credential.encryptionIv, PaddingScheme.PKCS5Padding);
    final contentEncrypted = await aes.encrypt(contentBytes);
    final metaEncrypted = await aes.encrypt(metaBytes);
    final hashValidator = new HmacValidator(await credential.getHashKey(_kdf));
    final checksum = hashValidator.computeChecksum(contentBytes);

    return _itemRepository.createItem(ItemEntity(
      id: _uuid.v4(),
      type: type,
      meta: metaEncrypted,
      content: contentEncrypted,
      checksum: checksum,
    ));
  }

  Future<Uint8List> decrypt(Uint8List source, PasswordCredential credential) async {
    final AES aes =
        AES.ofCBC(await credential.getEncryptionKey(_kdf), credential.encryptionIv, PaddingScheme.PKCS5Padding);
    return aes.decrypt(source);
  }
}
