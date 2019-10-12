import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/providers/view_models/responding_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';

class ItemListViewModel extends RespondingModel {
  final ItemListService _itemListService;
  List<Item> data;

  ItemListViewModel(ItemListService service)
      : _itemListService = service,
        data = [],
        super(State.IDLE);

  Future<void> fetch(int type) async {
    state = State.BUSY;

    await Future.delayed(Duration(seconds: 1)); // for testing

    data = await _itemListService.fetchByType(type);
    print('fetched data of :$type size: ${data.length}');
    state = State.IDLE;
  }
}
