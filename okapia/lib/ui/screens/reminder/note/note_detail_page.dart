import 'package:okapia/services/note_service.dart';
import 'package:okapia/stores/note_detail_store.dart';
import 'package:okapia/stores/note_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/model/choice.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('编辑', 'edit', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class NoteDetailPage extends StatefulWidget {
  final int _id;

  NoteDetailPage(this._id, {Key key}) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  NoteDetailStore _detailStore;

  @override
  void initState() {
    super.initState();
    _detailStore = new NoteDetailStore(
      widget._id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<NoteService>(context, listen: false),
    );
    _detailStore.fetch();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget _createBody() {
    return Observer(
        builder: (_) => _detailStore.isBusy
            ? Loading()
            : _displayNoteDetail(_detailStore.data.content.split("\n")));
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
          return Navigator.of(context)
              .pushReplacementNamed("/note/edit", arguments: widget._id);
        }
      case "delete":
        {
          return Provider.of<NoteStore>(context, listen: false)
              .delete(widget._id)
              .whenComplete(() => Navigator.of(context).pop());
        }
      default:
        break;
    }
  }
}
