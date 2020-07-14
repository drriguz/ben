import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/backend/stores/user_store.dart';

import '../common/services/item_service.dart';
import '../common/format/data_format.dart';
import '../common/format/data/abstract_data_model.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'item_list_store.g.dart';

class ItemListStore<T extends StructuredContent> = _ItemListStore<T> with _$ItemListStore<T>;

class BankcardStore extends ItemListStore {
  BankcardStore(UserStore userStore, ItemService itemService) : super(userStore, itemService, 1);
}

class CertificateStore extends ItemListStore {
  CertificateStore(UserStore userStore, ItemService itemService) : super(userStore, itemService, 2);
}

class NoteStore extends ItemListStore<NoteData> {
  final NoteService _noteService;

  NoteStore(UserStore userStore, ItemService itemService, this._noteService) : super(userStore, itemService, 3);

  Future<void> create(String content) {
    return persist(_noteService.createNote(content));
  }
}

abstract class _ItemListStore<T extends StructuredContent> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final ItemService _itemService;
  final int _itemType;

  @observable
  ObservableList<RawBriefRecord> _data = ObservableList<RawBriefRecord>();

  _ItemListStore(this._userStore, this._itemService, this._itemType) {}

  @action
  Future<void> fetch() async {
    setBusy();
    print('fetch data ${_itemType}...');
    _data.clear();
    _data.addAll(await _itemService.fetchByType(_itemType));
    setIdle();
  }

  @action
  Future<void> persist(T item) async {
    setBusy();
    return _itemService.create(_itemType, item, _userStore.userCredential).then((value) async {
      _data.clear();
      _data.addAll(await _itemService.fetchByType(_itemType));
    }).whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(String id) async {
    setBusy();
    return _itemService.delete(id).whenComplete(() => fetch()).whenComplete(() => setIdle());
  }

  ObservableList<RawBriefRecord> get data => _data;

  @computed
  int get totalCount => _data.length;
}
