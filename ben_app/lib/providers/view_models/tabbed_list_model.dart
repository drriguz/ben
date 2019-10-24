import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/sqlite/Item_entity.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';

import 'responding_model.dart';

abstract class AbstractTabbedListViewModel<
    T extends AbstractTabbedListViewModel<T>> extends PageStatusNotifier {
  final ItemListService _itemListService;
  final int type;
  final List<Item> data;

  AbstractTabbedListViewModel(State state, this._itemListService, this.type)
      : data = [],
        super(state) {
    //fetch();
    print("${this} created...");
  }

  Future<void> fetch() async {
    state = State.BUSY;

    data.clear();
    data.addAll(await _itemListService.fetchByType(type));
    print('fetched data of :$type size: ${data.length}');

    state = State.IDLE;
  }

  Future<T> decode<T extends Serializable>(Uint8List bytes,
      PasswordCredential credential, T Function(Map data) factory) async {
    return Serializer.fromMessagePack<T>(bytes, factory);
  }

  Future<void> persist<M extends Serializable>(M model) async {
    await _itemListService.create(type, model);
    return fetch();
  }

  @override
  void dispose() {
    super.dispose();
    print("${this} got disposed");
  }


}

class BankCardListViewModel
    extends AbstractTabbedListViewModel<BankCardListViewModel> {
  BankCardListViewModel(ItemListService itemListService)
      : super(State.IDLE, itemListService, 1);
}

class CertificateListViewModel
    extends AbstractTabbedListViewModel<CertificateListViewModel> {
  CertificateListViewModel(ItemListService itemListService)
      : super(State.IDLE, itemListService, 2);
}

class NoteListViewModel extends AbstractTabbedListViewModel<NoteListViewModel> {
  NoteListViewModel(ItemListService itemListService)
      : super(State.IDLE, itemListService, 3);
}
