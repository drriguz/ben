import 'data_format.dart';

abstract class HeaderRepository {
  Future<List<Header>> getHeaders();

  Future<void> saveHeaders(List<Header> headers);

  Future<Header> getHeader(int type);

  Future<void> deleteHeader(int type);

  Future<void> updateHeader(Header header);
}

abstract class ItemRepository {
  Future<List<Item>> getItems();

  Future<List<PreviewAble>> getItemsByType(int type);

  Future<Item> getById(String id);

  Future<void> createItem(Item item);

  Future<void> updateItem(String id, Item item);

  Future<void> deleteItem(String id);
}
