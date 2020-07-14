import '../common/services/item_service.dart';
import '../common/crypto/credential.dart';
import '../common/format/data_format.dart';
import '../common/format/model/abstract_model.dart';
import '../common/format/model/note_model.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'item_list_store.g.dart';

class ItemListStore = _ItemListStore with _$ItemListStore;

class BankcardStore extends ItemListStore {
  BankcardStore(ItemService itemListService) : super(itemListService, 1);
}

class CertificateStore extends ItemListStore {
  CertificateStore(ItemService itemListService) : super(itemListService, 2);
}

class NoteStore extends ItemListStore {
  NoteStore(ItemService itemListService) : super(itemListService, 3);
}

abstract class _ItemListStore<T extends AbstractMetaModel> extends PageStatusNotifier with Store {
  final ItemService _itemListService;
  final int _itemType;

  @observable
  ObservableList<RawBriefRecord> _data = ObservableList<RawBriefRecord>();

  _ItemListStore(this._itemListService, this._itemType) {}

  @action
  Future<void> fetch() async {
    setBusy();
    print('fetch data ${_itemType}...');
    _data.clear();
    _data.addAll(await _itemListService.fetchByType(_itemType));
    setIdle();
  }

  @action
  Future<void> save(NoteModel note, PasswordCredential credential) async {
    setBusy();
    return _itemListService.create(_itemType, note, credential).then((value) async {
      _data.clear();
      _data.addAll(await _itemListService.fetchByType(_itemType));
    }).whenComplete(() => setIdle());
  }

  ObservableList<RawBriefRecord> get data => _data;

  @computed
  int get totalCount => _data.length;
}
