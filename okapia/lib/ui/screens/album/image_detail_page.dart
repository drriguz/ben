import 'package:okapia/stores/image_detail_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/model/choice.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('设为相册封面', 'cover', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class ImageDetailPage extends StatefulWidget {
  final String _id;

  ImageDetailPage(this._id, {Key key}) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  ImageDetailStore _detailStore;

  @override
  void initState() {
    super.initState();
    _detailStore = new ImageDetailStore(
      Provider.of<UserStore>(context, listen: false),
      widget._id,
    );
    _detailStore.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("查看照片"),
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
      body: Observer(builder: (_) => _displayImageDetail()),
    );
  }

  Widget _displayImageDetail() {
    return _detailStore.item == null
        ? Loading()
        : Container(
            child: PhotoView(
            imageProvider: _detailStore.item,
          ));
  }

  Future<void> _onDropdownSelected(BuildContext context, MenuChoice choice) {
    switch (choice.value) {
      default:
        break;
    }
  }
}
