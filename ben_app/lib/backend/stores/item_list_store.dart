import 'dart:io';
import 'dart:typed_data';

import 'package:ben_app/backend/common/format/data/album_model.dart';
import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:ben_app/backend/common/format/data/list_item_model.dart';
import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/common/format/data_format.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/services/album_service.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/backend/stores/user_store.dart';

import '../common/services/item_service.dart';
import '../common/format/data/abstract_data_model.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'item_list_store.g.dart';

class ItemListStore<M extends StructuredMeta,
        C extends StructuredContent> = _ItemListStore<M, C>
    with _$ItemListStore<M, C>;

class NoteStore extends ItemListStore<NoteMeta, NoteData> {
  final NoteService _noteService;

  NoteStore(UserStore userStore, ItemService itemService, this._noteService)
      : super(
          userStore,
          itemService,
          TYPE_NOTE,
          (meta) =>
              Serializer.fromJson<NoteMeta>(meta, (_) => NoteMeta.fromJson(_)),
        ) {
    print("create not store");
  }

  Future<void> createOrUpdate(String id, String content) {
    return createOrUpdateRawRecord(id, _noteService.createNote(content));
  }
}

class AlbumStore extends ItemListStore<AlbumMeta, AlbumData> {
  final AlbumService _albumService;

  AlbumStore(UserStore userStore, ItemService itemService, this._albumService)
      : super(
          userStore,
          itemService,
          TYPE_ALBUM,
          (meta) => Serializer.fromJson<AlbumMeta>(
              meta, (_) => AlbumMeta.fromJson(_)),
        );

  Future<void> createOrUpdate(String id, String name) {
    return createOrUpdateRawRecord(id, _albumService.createAlbum(name));
  }
}

typedef Decoder<M extends StructuredMeta> = M Function(Uint8List content);

abstract class _ItemListStore<M extends StructuredMeta,
    C extends StructuredContent> extends PageStatusNotifier with Store {
  final UserStore userStore;
  final ItemService itemService;
  final int itemType;
  final Decoder<M> metaDecoder;

  @observable
  ObservableList<ListItemModel<M>> data = ObservableList<ListItemModel<M>>();

  _ItemListStore(
      this.userStore, this.itemService, this.itemType, this.metaDecoder) {}

  @action
  Future<void> fetch() async {
    setBusy();
    print('fetch data ${itemType}...');
    data.clear();
    final List<RawBriefRecord> rawRecords =
        await itemService.fetchByType(itemType);
    data.addAll(await Future.wait(rawRecords.map((e) => decodeMeta(e))));
    setIdle();
  }

  Future<ListItemModel<M>> decodeMeta(RawBriefRecord record) {
    return itemService
        .decrypt(record.meta, userStore.userCredential)
        .then((value) => ListItemModel(record.id, metaDecoder.call(value)));
  }

  @action
  Future<void> createOrUpdateRawRecord(String id, C item) async {
    setBusy();
    return itemService
        .createOrUpdate(itemType, id, item, userStore.userCredential)
        .then((rawRecord) async => data.add(await decodeMeta(rawRecord)))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> delete(String id) async {
    setBusy();
    return itemService
        .delete(id)
        .whenComplete(() => fetch())
        .whenComplete(() => setIdle());
  }

  @computed
  int get totalCount => data.length;
}
