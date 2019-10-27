import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/mobx/item_list_store.dart';
import 'package:ben_app/ui/model/bank_card_model.dart';
import 'package:ben_app/ui/model/certificate_model.dart';
import 'package:ben_app/ui/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widget/bank_card_item.dart';
import 'widget/certificate_card_item.dart';
import 'widget/empty_list_tip.dart';
import 'widget/list_item_placeholder.dart';
import 'widget/note_item.dart';

abstract class ItemListPage<T extends ItemListStore, M extends Serializable>
    extends StatelessWidget {
  final T _store;

  const ItemListPage(this._store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    if (_store.totalCount == 0)
      return EmptyListTipWidget(onRefresh: _onRefresh);
    return ListView.builder(
        itemCount: _store.totalCount,
        itemBuilder: (_, int index) {
          return _createListItem(_store.data[index]);
        });
  }

  Future<M> _decode(Item data);

  Widget _renderModel(M model);

  Widget _createListItem(Item data) {
    return FutureBuilder<M>(
      future: _decode(data),
      builder: (BuildContext _, AsyncSnapshot<M> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _renderModel(snapshot.data);
          default:
            return ItemPlaceholder();
        }
      },
    );
  }
}

class NoteListPage extends ItemListPage<NoteStore, NoteModel> {
  NoteListPage(NoteStore store) : super(store);

  @override
  Future<NoteModel> _decode(Item data) async {
    return Serializer.fromMessagePack<NoteModel>(
        data.content, (_) => NoteModel.fromMap(_));
  }

  @override
  Widget _renderModel(NoteModel model) {
    return NoteItem(model: model);
  }
}

class BankcardListPage extends ItemListPage<BankcardStore, BankCardModel> {
  BankcardListPage(BankcardStore store) : super(store);

  @override
  Future<BankCardModel> _decode(Item data) async {
    return Serializer.fromMessagePack<BankCardModel>(
        data.content, (_) => BankCardModel.fromMap(_));
  }

  @override
  Widget _renderModel(BankCardModel model) {
    return BankCardItem(model: model);
  }
}

class CertificateListPage
    extends ItemListPage<CertificateStore, CertificateModel> {
  CertificateListPage(CertificateStore store) : super(store);

  @override
  Future<CertificateModel> _decode(Item data) async {
    return Serializer.fromMessagePack<CertificateModel>(
        data.content, (_) => CertificateModel.fromMap(_));
  }

  @override
  Widget _renderModel(CertificateModel model) {
    return CertificateCardItem(model: model);
  }
}
