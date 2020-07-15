import 'dart:typed_data';

import 'package:ben_app/backend/common/format/data/abstract_data_model.dart';
import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'item_detail_store.g.dart';

abstract class ItemDetailStore<T extends StructuredContent> = _ItemDetailStore<T> with _$ItemDetailStore<T>;

abstract class _ItemDetailStore<T extends StructuredContent> extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final ItemService _itemService;

  @observable
  T item;

  _ItemDetailStore(this._userStore, this._itemService);

  T convert(Uint8List content);

  Future<void> refreshList();

  @action
  Future<void> fetch(String id) {
    setBusy();
    return _itemService
        .fetchAndDecryptContent(id, _userStore.userCredential)
        .then((value) => convert(value))
        .then((value) => item = value)
        .whenComplete(() => setIdle())
        .whenComplete(() => refreshList());
  }
}

class NoteDetailStore extends ItemDetailStore<NoteData> {
  final NoteStore _noteStore;

  NoteDetailStore(UserStore userStore, ItemService itemService, this._noteStore) : super(userStore, itemService) {
    print("creating note detail store...");
  }

  @override
  NoteData convert(Uint8List content) {
    return Serializer.fromJson<NoteData>(content, (_) => NoteData.fromJson(_));
  }

  @override
  Future<void> refreshList() {
    return _noteStore.fetch();
  }

  @action
  Future<void> delete(String id) {
    return _noteStore.delete(id).whenComplete(() => refreshList());
  }
}
