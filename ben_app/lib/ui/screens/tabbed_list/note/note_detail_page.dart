import 'package:ben_app/backend/stores/item_detail_store.dart';
import 'package:ben_app/ui/model/choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('编辑', 'edit', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class NoteDetailPage extends StatelessWidget {
  final String _id;
  final NoteDetailStore _detailStore;

  NoteDetailPage(this._id, this._detailStore, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build...');
    _detailStore.fetch(_id);
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
    return Observer(
        builder: (_) =>
            _detailStore.isBusy ? _inProgress() : _displayNoteDetail(_detailStore.item.content.split("\n")));
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

  Future<void> _onDropdownSelected(BuildContext context, MenuChoice choice) {
    switch (choice.value) {
      case "edit":
        {
          return Navigator.of(context).pushReplacementNamed("/note/edit", arguments: _id);
        }
      case "delete":
        {
          return _detailStore.delete(_id).whenComplete(() => Navigator.of(context).pop());
        }
      default:
        break;
    }
  }
}
