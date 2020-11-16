import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/sqlcipher/model/image.dart';
import 'package:okapia/services/image_service.dart';
import 'package:okapia/stores/image_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/model/choice.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'image_item.dart';

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('编辑', 'edit', Icons.edit),
  const MenuChoice('删除', 'delete', Icons.delete),
];

class AlbumDetailPage extends StatefulWidget {
  final int _id;

  AlbumDetailPage(this._id, {Key key}) : super(key: key);

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState(_id);
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  final int _id;

  _AlbumDetailPageState(this._id);

  final ImagePicker _picker = ImagePicker();
  ImageStore _imageStore;

  @override
  void initState() {
    super.initState();
    _imageStore = ImageStore(
      Provider.of<UserStore>(context, listen: false),
      Provider.of<ImageService>(context, listen: false),
      _id,
    );
    _imageStore.fetch();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Observer(
          builder: (_) => _imageStore.isBusy
              ? Loading()
              : _displayAlbumImages(_imageStore)),
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.0),
        itemCount: imageStore.data.length,
        itemBuilder: (context, index) => _createImage(imageStore.data[index]),
      ),
    );
  }

  Widget _createImage(ImageModel item) {
    return ImageItem(
      item.id,
      item.path,
      null,
    );
  }

  Future<void> _onDropdownSelected(BuildContext context, MenuChoice choice) {
    switch (choice.value) {
      case "edit":
        {
          return Navigator.of(context)
              .pushReplacementNamed("/album/edit", arguments: _id);
        }

      default:
        break;
    }
  }

  Future<void> _takePhoto() async {
    UserStore userStore = Provider.of<UserStore>(context);
    userStore.isPausedToTakePhoto = true;
    final image = await _picker
        .getImage(source: ImageSource.camera, imageQuality: 50)
        .catchError((err) => null)
        .whenComplete(() => userStore.isPausedToTakePhoto = false);
    if (image == null) return;
    print('Start to save image...');
    return _imageStore.create(File(image.path));
  }
}
