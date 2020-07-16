import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/backend/common/format/data/abstract_data_model.dart';
import 'package:ben_app/backend/common/format/data/album_model.dart';
import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';
import 'user_store.dart';

part 'item_detail_store.g.dart';

abstract class ItemDetailStore<T extends StructuredContent> = _ItemDetailStore<
    T> with _$ItemDetailStore<T>;

abstract class _ItemDetailStore<T extends StructuredContent>
    extends PageStatusNotifier with Store {
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

  NoteDetailStore(UserStore userStore, ItemService itemService, this._noteStore)
      : super(userStore, itemService) {
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
}

class AlbumDetailStore extends ItemDetailStore<AlbumData> {
  final AlbumStore _albumStore;

  AlbumDetailStore(
      UserStore userStore, ItemService itemService, this._albumStore)
      : super(userStore, itemService);

  @override
  AlbumData convert(Uint8List content) {
    return Serializer.fromJson<AlbumData>(
        content, (_) => AlbumData.fromJson(_));
  }

  @override
  Future<void> refreshList() {
    return _albumStore.fetch();
  }
}

class ImageDetailStore with Store {
  final UserStore _userStore;
  final ItemService _itemService;
  final String _id;

  @observable
  ImageProvider<dynamic> item;

  ImageDetailStore(this._userStore, this._itemService, this._id);

  @action
  Future<void> fetch() {
    return _itemService
        .fetchAndDecryptContent(_id, _userStore.userCredential)
        .then((value) =>
            Serializer.fromJson<ImageData>(value, (_) => ImageData.fromJson(_)))
        .then((value) => item = MemoryImage(base64.decode(value.image)));
  }
}
