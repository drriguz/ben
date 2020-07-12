import 'package:ben_app/backend/mobx/note_detail_store.dart';
import 'package:ben_app/format/record/abstract_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteDetailStore _store;

  const NoteDetailPage(this._store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractDataRecord argument = ModalRoute.of(context).settings.arguments;
    print("------${argument}");
    print(argument.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("查看记事"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            _store.noteModel.content,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
