import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/mobx/page_status_notifier.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';
import 'package:mobx/mobx.dart';

part 'item_list_store.g.dart';

class ItemListStore = _ItemListStore with _$ItemListStore;

class BankcardStore extends ItemListStore {
  BankcardStore(ItemListService itemListService) : super(itemListService, 1);
}

class CertificateStore extends ItemListStore {
  CertificateStore(ItemListService itemListService) : super(itemListService, 2);
}

class NoteStore extends ItemListStore {
  NoteStore(ItemListService itemListService) : super(itemListService, 3);
}

abstract class _ItemListStore extends PageStatusNotifier with Store {
  final ItemListService _itemListService;
  final int _itemType;

  @observable
  ObservableList<Item> _data = ObservableList<Item>();

  _ItemListStore(this._itemListService, this._itemType) {
    fetch();
  }

  @action
  Future<void> fetch() async {
    setBusy();
    _data.clear();
    _data.addAll(await _itemListService.fetchByType(_itemType));
    setIdle();
  }

  @action
  Future<void> save(NoteModel note) async {
    setBusy();
    await _itemListService.create(_itemType, note);
    _data.clear();
    _data.addAll(await _itemListService.fetchByType(_itemType));
    setIdle();
  }

  ObservableList<Item> get data => _data;

  @computed
  int get totalCount => _data.length;
}
