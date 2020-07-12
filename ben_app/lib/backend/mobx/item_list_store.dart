import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/record/note_record.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

abstract class _ItemListStore extends PageStatusNotifier with Store {
  final ItemService _itemListService;
  final int _itemType;

  @observable
  ObservableList<Item> _data = ObservableList<Item>();

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
    return _itemListService.create<NoteModel>(_itemType, note, credential).then((value) async {
      _data.clear();
      _data.addAll(await _itemListService.fetchByType(_itemType));
    }).whenComplete(() => setIdle());
  }

  ObservableList<Item> get data => _data;

  @computed
  int get totalCount => _data.length;
}
