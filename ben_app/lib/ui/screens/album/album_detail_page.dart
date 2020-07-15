import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/stores/item_detail_store.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:ben_app/backend/stores/user_store.dart';
import 'package:ben_app/ui/model/choice.dart';
import 'package:ben_app/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'album_item.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('编辑', 'edit', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class AlbumDetailPage extends StatefulWidget {
  final String _id;

  AlbumDetailPage(this._id, {Key key}) : super(key: key);

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState(_id);
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  final String _id;

  _AlbumDetailPageState(this._id);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageStore imageStore = Provider.of<ImageStore>(context);
    imageStore.fetch();
    return Scaffold(
      appBar: AppBar(
        title: Text("查看相册"),
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
      body: _createBody(imageStore),
    );
  }

  Widget _createBody(ImageStore imageStore) {
    return Observer(builder: (_) => imageStore.isBusy ? Loading() : _displayAlbumImages());
  }

  Widget _displayAlbumImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.0),
        itemCount: 1,
        itemBuilder: (context, index) => AlbumItem("1", "text", 1),
      ),
    );
  }

  Future<void> _onDropdownSelected(BuildContext context, MenuChoice choice) {
    AlbumStore albumStore = Provider.of<AlbumStore>(context);
    switch (choice.value) {
      case "edit":
        {
          return Navigator.of(context).pushReplacementNamed("/album/edit", arguments: _id);
        }
      case "delete":
        {
          return albumStore.delete(_id).whenComplete(() => Navigator.of(context).pop());
        }
      default:
        break;
    }
  }
}
