import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/providers/view_models/responding_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';

class AddNoteViewModel extends PageStatusNotifier {
  final ItemListService _itemListService;

  AddNoteViewModel(ItemListService service)
      : _itemListService = service,
        super(State.IDLE);

  Future<void> create(int type, String content) async {
    state = State.BUSY;

    await _itemListService.create(
        type, NoteModel(title: 'New note', content: content));

    state = State.IDLE;
  }
}
