import 'dart:convert';

import 'package:ben_app/crypto/credential.dart';
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

  Future<void> create<T extends Serializable>(int type, T data) async {
    final bytes = Serializer.toMessagePack(data);
    return _itemRepository.createItem(ItemEntity(
      id: _uuid.v4(),
      type: type,
      content: bytes,
      checksum: utf8.encode("12345"), //fixme
    ));
  }

  Future<void> create1<T extends Serializable>(int type, T data, PasswordCredential credential) async{
    final bytes = Serializer.toMessagePack(data);
    // final encrypted = Encryptions.aesEncrypt(credential.getEncryptionKey(_kdf), credential., value)
  }
}
