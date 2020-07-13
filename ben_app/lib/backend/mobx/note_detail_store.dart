import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'note_detail_store.g.dart';

class NoteDetailStore = _NoteDetailStore with _$NoteDetailStore;

abstract class _NoteDetailStore extends PageStatusNotifier with Store {
  final ItemService _itemService;
  @observable
  RawRecord noteDetail;

  _NoteDetailStore(this._itemService);

  @action
  Future<void> fetch(String id) async {
    setBusy();
    print('fetch data ${id}...');
    _itemService.fetchById(id).then((value) => noteDetail = value).whenComplete(() => setIdle());
  }
}
