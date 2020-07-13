import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/backend/mobx/note_detail_store.dart';
import 'package:ben_app/backend/mobx/user_store.dart';
import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/model/list_item_model.dart';
import 'package:ben_app/format/model/note_model.dart';
import 'package:ben_app/format/serializer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteDetailStore _noteDetailStore;
  final UserStore _userStore;
  final ItemService _itemService;

  const NoteDetailPage(this._noteDetailStore, this._userStore, this._itemService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListItemModel<NoteMetaModel> argument = ModalRoute.of(context).settings.arguments;
    _noteDetailStore.fetch(argument.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("查看记事"),
      ),
      body: Observer(
        builder: (_) => _noteDetailStore.isBusy ? _inProgress() : _createBody(_noteDetailStore.noteDetail),
      ),
    );
  }

  Widget _inProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _createBody(RawRecord rawRecord) {
    assert(rawRecord != null);
    return FutureBuilder<NoteModel>(
      future: _decodeEncrypted(rawRecord),
      builder: (BuildContext _, AsyncSnapshot<NoteModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              print(snapshot.error);
              return _inProgress();
            }
            return _displayNoteDetail(snapshot.data);
          default:
            return _inProgress();
        }
      },
    );
  }

  Widget _displayNoteDetail(NoteModel note) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Text(
          note.content,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<NoteModel> _decodeEncrypted(RawRecord entity) async {
    return _itemService
        .decrypt(entity.content, _userStore.userCredential)
        .then((value) => Serializer.fromJson<NoteModel>(value, (_) => NoteModel.fromJson(_)));
  }
}
