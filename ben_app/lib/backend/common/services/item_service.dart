import 'dart:typed_data';
import 'package:encryptions/encryptions.dart';
import 'package:uuid/uuid.dart';

import '../crypto/credential.dart';
import '../crypto/hmac_validator.dart';
import '../crypto/kdf.dart';
import '../format/data_format.dart';
import '../format/data/abstract_data_model.dart';
import '../format/serializer.dart';
import '../format/sqlite/Item_entity.dart';
import '../format/storage.dart';

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

  Future<void> create(int type, StructuredContent data, PasswordCredential credential) async {
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

  Future<Uint8List> fetchAndDecryptMeta(String id, PasswordCredential credential) async {
    final RawRecord record = await fetchById(id);
    if (record == null) throw ArgumentError("Item not found with id = $id");
    return decrypt(record.meta, credential);
  }

  Future<Uint8List> fetchAndDecryptContent(String id, PasswordCredential credential) async {
    final RawRecord record = await fetchById(id);
    if (record == null) throw ArgumentError("Item not found with id = $id");
    return decrypt(record.content, credential);
  }
}