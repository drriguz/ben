import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/services/album_service.dart';
import 'package:ben_app/backend/stores/image_store.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:ben_app/backend/stores/user_store.dart';
import 'package:ben_app/ui/model/choice.dart';
import 'package:ben_app/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'album_item.dart';
import 'image_item.dart';

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

  final ImagePicker _picker = ImagePicker();
  ImageStore _imageStore;

  @override
  void initState() {
    super.initState();
    _imageStore = ImageStore(
      Provider.of<UserStore>(context, listen: false),
      Provider.of<ItemService>(context, listen: false),
      _id,
      Provider.of<AlbumService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    _imageStore.fetch();
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
      body: Observer(builder: (_) => _imageStore.isBusy ? Loading() : _displayAlbumImages(_imageStore)),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        tooltip: 'Create album',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _displayAlbumImages(ImageStore imageStore) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
        itemCount: imageStore.data.length,
        itemBuilder: (context, index) => ImageItem(
          imageStore.data[index].id,
          imageStore.data[index].meta.title,
          imageStore.data[index].meta.thumb,
        ),
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

  Future<void> _takePhoto() async {
    UserStore _userStore = Provider.of<UserStore>(context);
    _userStore.isPausedToTakePhoto = true;
    final image = await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return;
    return _imageStore.create(image).whenComplete(() => _userStore.isPausedToTakePhoto = false);
  }
}
