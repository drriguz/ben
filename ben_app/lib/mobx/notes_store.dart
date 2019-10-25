import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/mobx/page_status_notifier.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';
import 'package:ben_app/providers/services/login_service.dart';
import 'package:mobx/mobx.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore extends PageStatusNotifier with Store {
  final ItemListService _itemListService;

  @observable
  ObservableList<Item> _data = ObservableList<Item>();

  _NotesStore(this._itemListService);

  @action
  Future<void> fetch() async {
    setBusy();
    _data.clear();
    _data.addAll(await _itemListService.fetchByType(4));
    setIdle();
  }

  @computed
  int get totalCount => _data.length;
}
