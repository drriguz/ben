import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/backend/mobx/item_list_store.dart';
import 'package:ben_app/backend/mobx/user_store.dart';
import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/model/abstract_model.dart';
import 'package:ben_app/format/model/list_item_model.dart';
import 'package:ben_app/format/model/note_model.dart';
import 'package:ben_app/format/serializer.dart';
import 'package:ben_app/ui/model/bank_card_model.dart';
import 'package:ben_app/ui/model/certificate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'bankcard/bank_card_item.dart';
import 'certificate/certificate_card_item.dart';
import 'widget/empty_list_tip.dart';
import 'widget/list_item_placeholder.dart';
import 'note/note_item.dart';

abstract class ItemListPage<T extends ItemListStore, M extends AbstractMetaModel> extends StatelessWidget {
  final T _store;
  final UserStore _userStore;
  final ItemService _itemService;

  const ItemListPage(this._store, this._userStore, this._itemService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    return Observer(
      builder: (_) {
        return _store.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _createList(),
                onRefresh: _onRefresh,
              );
      },
    );
  }

  Future<void> _onRefresh() async {
    return _store.fetch();
  }

  Widget _createList() {
    if (_store.totalCount == 0) return EmptyListTipWidget(onRefresh: _onRefresh);
    return ListView.builder(
        itemCount: _store.totalCount,
        itemBuilder: (_, int index) {
          return _createListItem(_store.data[index]);
        });
  }

  Future<M> _decode(Uint8List meta);

  Future<M> _decodeEncrypted(RawRecord entity) async {
    try {
      Uint8List meta = await _itemService.decrypt(entity.meta, _userStore.userCredential);
      print('decrypted meta:${utf8.decode(meta)}');
      final result = await _decode(meta);
      return result;
    } catch (err, stack) {
      print("error: ${err} ${stack}");
      throw err;
    }
  }

  Widget _renderModel(ListItemModel<M> model);

  Widget _createListItem(RawRecord data) {
    return FutureBuilder<M>(
      future: _decodeEncrypted(data),
      builder: (BuildContext _, AsyncSnapshot<M> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              print(snapshot.error);
              return ItemPlaceholder();
            }
            return _renderModel(new ListItemModel(data.id, snapshot.data));
          default:
            return ItemPlaceholder();
        }
      },
    );
  }
}

class NoteListPage extends ItemListPage<NoteStore, NoteMetaModel> {
  NoteListPage(NoteStore store, UserStore userStore, ItemService itemService) : super(store, userStore, itemService);

  @override
  Future<NoteMetaModel> _decode(Uint8List meta) async {
    return Serializer.fromJson<NoteMetaModel>(meta, (_) => NoteMetaModel.fromJson(_));
  }

  @override
  Widget _renderModel(ListItemModel<NoteMetaModel> model) {
    return NoteItem(model);
  }
}

//class BankcardListPage extends ItemListPage<BankcardStore, BankCardModel> {
//  BankcardListPage(BankcardStore store, UserStore userStore, ItemService itemService)
//      : super(store, userStore, itemService);
//
//  @override
//  Future<BankCardModel> _decode(Uint8List content) async {
//    return Serializer.fromJson<BankCardModel>(content, (_) => BankCardModel.fromMap(_));
//  }
//
//  @override
//  Widget _renderModel(ListItemModel<BankCardModel> model) {
//    return BankCardItem(model: model);
//  }
//}
//
//class CertificateListPage extends ItemListPage<CertificateStore, CertificateModel> {
//  CertificateListPage(CertificateStore store, UserStore userStore, ItemService itemService)
//      : super(store, userStore, itemService);
//
//  @override
//  Future<CertificateModel> _decode(Uint8List content) async {
//    return Serializer.fromJson<CertificateModel>(content, (_) => CertificateModel.fromMap(_));
//  }
//
//  @override
//  Widget _renderModel(CertificateModel model) {
//    return CertificateCardItem(model: model);
//  }
//}
