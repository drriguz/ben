import 'package:flutter/foundation.dart';
import 'package:okapia/db/model/note_model.dart';
import 'package:okapia/services/note_service.dart';
import 'package:okapia/states/user_state.dart';

class NotesState extends ChangeNotifier {
  final UserState _userState;
  final NoteService _noteService;
  final List<NoteModel> _items = [];

  NotesState(this._noteService, this._userState);

  List<NoteModel> get items => _items;

  Future<void> fetch() async {
    _items.clear();
    var notes = await _noteService.fetchAll(_userState.database!);
    _items.addAll(notes);
    notifyListeners();
  }
}
