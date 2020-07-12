import 'data_format.dart';

abstract class HeaderRepository {
  Future<List<Header>> getHeaders();

  Future<void> saveHeaders(List<Header> headers);

  Future<Header> getHeader(int type);

  Future<void> deleteHeader(int type);

  Future<void> updateHeader(Header header);
}

abstract class ItemRepository {
  Future<List<RawBriefRecord>> getItems();

  Future<List<RawBriefRecord>> getItemsByType(int type);

  Future<RawRecord> getById(String id);

  Future<void> createItem(RawRecord item);

  Future<void> updateItem(String id, RawRecord item);

  Future<void> deleteItem(String id);
}
