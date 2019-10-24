import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/providers/view_models/responding_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';

class ItemListViewModel extends PageStatusNotifier {
  final ItemListService _itemListService;
  final int type;
  List<Item> data;

  ItemListViewModel(ItemListService service, int type)
      : _itemListService = service,
        data = [],
        type = type,
        super(State.IDLE);

  Future<void> fetch() async {
    state = State.BUSY;

    data = await _itemListService.fetchByType(type);
    print('fetched data of :$type size: ${data.length}');

    state = State.IDLE;
  }
}
