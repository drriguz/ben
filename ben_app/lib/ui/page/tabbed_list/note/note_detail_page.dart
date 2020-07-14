import 'package:ben_app/backend/mobx/item_list_store.dart';
import 'package:ben_app/backend/mobx/user_store.dart';
import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/format/model/note_model.dart';
import 'package:ben_app/format/serializer.dart';
import 'package:ben_app/ui/model/choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('编辑', 'edit', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class NoteDetailPage extends StatelessWidget {
  final String _id;
  final NoteStore _noteStore;
  final UserStore _userStore;
  final ItemService _itemService;

  NoteDetailPage(this._id, this._noteStore, this._userStore, this._itemService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build...');
    return Scaffold(
      appBar: AppBar(
        title: Text("查看记事"),
        actions: <Widget>[
          PopupMenuButton<MenuChoice>(
            onSelected: (choice) => _onDropdownSelected(context, choice),
            itemBuilder: (BuildContext context) {
              return menuItems.map((MenuChoice choice) {
                return PopupMenuItem<MenuChoice>(
                  value: choice,
                  child: ListTile(
                    leading: Icon(choice.icon),
                    title: Text(choice.displayName),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _createBody(),
    );
  }

  Widget _inProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _createBody() {
    return FutureBuilder<List<String>>(
      future: _fetchAndDecodeEncrypted(),
      builder: (BuildContext _, AsyncSnapshot<List<String>> snapshot) {
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

  Widget _displayNoteDetail(List<String> contents) {
    final textStyle = TextStyle(fontSize: 16);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (_, int index) {
            return Text(contents[index], style: textStyle);
          }),
    );
  }

  Future<List<String>> _fetchAndDecodeEncrypted() async {
    return _itemService
        .fetchById(_id)
        .then((entity) => _itemService.decrypt(entity.content, _userStore.userCredential))
        .then((value) => Serializer.fromJson<NoteModel>(value, (_) => NoteModel.fromJson(_)))
        .then((value) => value.content.split("\n"));
  }

  void _onDropdownSelected(BuildContext context, MenuChoice choice) {
    switch (choice.value) {
      case "edit":
      case "delete":
        {
          _itemService
              .delete(_id)
              .whenComplete(() => Navigator.of(context).pop())
              .whenComplete(() => _noteStore.fetch());
          return;
        }
      default:
        break;
    }
  }
}
