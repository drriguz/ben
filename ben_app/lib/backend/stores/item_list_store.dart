import 'dart:typed_data';

import 'package:ben_app/backend/common/format/data/list_item_model.dart';
import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/common/format/data_format.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/backend/stores/user_store.dart';

import '../common/services/item_service.dart';
import '../common/format/data/abstract_data_model.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'item_list_store.g.dart';

class ItemListStore<M extends StructuredMeta, C extends StructuredContent> = _ItemListStore<M, C>
    with _$ItemListStore<M, C>;

class NoteStore extends ItemListStore<NoteMeta, NoteData> {
  final NoteService _noteService;

  NoteStore(UserStore userStore, ItemService itemService, this._noteService)
      : super(
          userStore,
          itemService,
          3,
          (meta) => Serializer.fromJson<NoteMeta>(meta, (_) => NoteMeta.fromJson(_)),
        ) {
    print("create not store");
  }

  Future<void> createOrUpdate(String id, String content) {
    return createOrUpdateRawRecord(id, _noteService.createNote(content));
  }
}

typedef Decoder<M extends StructuredMeta> = M Function(Uint8List content);

abstract class _ItemListStore<M extends StructuredMeta, C extends StructuredContent> extends PageStatusNotifier
    with Store {
  final UserStore _userStore;
  final ItemService _itemService;
  final int _itemType;
  final Decoder<M> _metaDecoder;

  @observable
  ObservableList<ListItemModel<M>> _data = ObservableList<ListItemModel<M>>();

  _ItemListStore(this._userStore, this._itemService, this._itemType, this._metaDecoder) {}

  @action
  Future<void> fetch() async {
    setBusy();
    print('fetch data ${_itemType}...');
    _data.clear();
    final List<RawBriefRecord> rawRecords = await _itemService.fetchByType(_itemType);
    _data.addAll(await Future.wait(rawRecords.map((e) => _decodeMeta(e))));
    setIdle();
  }

  Future<ListItemModel<M>> _decodeMeta(RawBriefRecord record) {
    return _itemService
        .decrypt(record.meta, _userStore.userCredential)
        .then((value) => ListItemModel(record.id, _metaDecoder.call(value)));
  }

  @action
  Future<void> createOrUpdateRawRecord(String id, C item) async {
    setBusy();
    return _itemService
        .createOrUpdate(_itemType, id, item, _userStore.userCredential)
        .whenComplete(() => fetch())
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(String id) async {
    setBusy();
    return _itemService.delete(id).whenComplete(() => fetch()).whenComplete(() => setIdle());
  }

  ObservableList<ListItemModel<M>> get data => _data;

  @computed
  int get totalCount => _data.length;
}
