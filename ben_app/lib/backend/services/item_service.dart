import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/format/storage.dart';
import 'package:encryptions/encryptions.dart';
import 'package:uuid/uuid.dart';

class ItemService {
  final ItemRepository _itemRepository;
  final Kdf _kdf;

  final _uuid = new Uuid();

  ItemService(this._itemRepository, this._kdf);

  Future<List<Item>> fetchByType(int type) async {
    await Future.delayed(Duration(seconds: 1));
    return _itemRepository.getItemsByType(type);
  }


  Future<void> create<T extends Serializable>(
      int type, T data, PasswordCredential credential) async {
    final bytes = Serializer.toMessagePack(data);
    final encrypted = await Encryptions.aesEncrypt(
        await credential.getEncryptionKey(_kdf),
        credential.encryptionIv,
        bytes);
    final hashValidator = new HmacValidator(await credential.getHashKey(_kdf));
    final checksum = hashValidator.computeChecksum(bytes);

    return _itemRepository.createItem(ItemEntity(
      id: _uuid.v4(),
      type: type,
      content: encrypted,
      checksum: checksum,
    ));
  }

  Future<Uint8List> decrypt(
      Uint8List source, PasswordCredential credential) async {
    return Encryptions.aesDecrypt(
      await credential.getEncryptionKey(_kdf),
      credential.encryptionIv,
      source,
    );
  }
}
