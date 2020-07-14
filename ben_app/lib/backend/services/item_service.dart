import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/model/abstract_model.dart';
import 'package:ben_app/format/serializer.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/format/storage.dart';
import 'package:encryptions/encryptions.dart';
import 'package:uuid/uuid.dart';

class ItemService {
  final ItemRepository _itemRepository;
  final Kdf _kdf;

  final _uuid = new Uuid();

  ItemService(this._itemRepository, this._kdf);

  Future<List<RawBriefRecord>> fetchByType(int type) async {
    return _itemRepository.getItemsByType(type);
  }

  Future<RawRecord> fetchById(String id) async {
    return _itemRepository.getById(id);
  }

  Future<void> delete(String id) async {
    return _itemRepository.deleteItem(id);
  }

  Future<void> create(int type, AbstractContentModel data, PasswordCredential credential) async {
    final contentBytes = Serializer.toJson(data);
    final metaBytes = Serializer.toJson(data.createMeta());
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
    print('aes decrypt begin...');
    final AES aes =
        AES.ofCBC(await credential.getEncryptionKey(_kdf), credential.encryptionIv, PaddingScheme.PKCS5Padding);
    return aes.decrypt(source);
  }
}
