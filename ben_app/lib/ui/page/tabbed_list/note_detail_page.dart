import 'package:ben_app/backend/mobx/item_list_store.dart';
import 'package:ben_app/backend/mobx/note_detail_store.dart';
import 'package:ben_app/backend/mobx/user_store.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/ui/model/note_model.dart';
import 'package:ben_app/ui/theme/icons.dart';
import 'package:ben_app/ui/widgets/tool_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteDetailStore _store;

  const NoteDetailPage(this._store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("查看记事"),
      ),
      body: Center(
        child: Text(_store.noteModel.content),
      ),
    );
  }
}
