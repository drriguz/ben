import 'package:ben_app/backend/services/login_service.dart';
import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/record/note_record.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'note_detail_store.g.dart';

class NoteDetailStore = _NoteDetailStore with _$NoteDetailStore;

abstract class _NoteDetailStore with Store {
  @observable
  NoteModel _noteModel;

  NoteModel get noteModel => _noteModel;

  @action
  void setSelected(NoteModel model) {
    _noteModel = model;
  }
}
