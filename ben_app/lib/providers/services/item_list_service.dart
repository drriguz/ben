
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/storage.dart';
import 'package:ben_app/plugins/bank_card/bank_card_model.dart';

class ItemListService {
  ItemRepository itemRepository;

  ItemListService();

  Future<List<BankCardModel>> fetch() async {
    print('fetching...');
    final items = await itemRepository.getItems();
    print('fetched: ${items.length}');
    return items.map((item) => BankCardModel(title: item.id)).toList();
  }

  Future<List<Item>> fetchByType(int type) async {
    return itemRepository.getItemsByType(type);
  }
}
