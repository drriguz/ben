import 'dart:convert';

import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/format/storage.dart';
import 'package:uuid/uuid.dart';

class ItemListService {
  ItemRepository itemRepository;
  final uuid = new Uuid();

  ItemListService();

  Future<List<Item>> fetchByType(int type) async {
    await Future.delayed(Duration(seconds: 1));
    return itemRepository.getItemsByType(type);
  }

  Future<void> create<T extends Serializable>(int type, T data) async {
    final bytes = Serializer.toMessagePack(data);
    return itemRepository.createItem(ItemEntity(
      id: uuid.v4(),
      type: type,
      content: bytes,
      checksum: utf8.encode("12345"), //fixme
    ));
  }
}
