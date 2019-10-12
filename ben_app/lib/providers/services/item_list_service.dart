
import 'package:ben_app/format/storage.dart';
import 'package:ben_app/plugins/bank_card/bank_card.dart';

class ItemListService {
  ItemRepository itemRepository;

  ItemListService();

  Future<List<BankCard>> fetch() async {
    print('fetching...');
    final items = await itemRepository.getItems();
    print('fetched: ${items.length}');
    return items.map((item) => BankCard(title: item.id)).toList();
  }
}
