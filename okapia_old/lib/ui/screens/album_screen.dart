import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/stores/album_store.dart';
import 'package:okapia/ui/screens/camera/take_picture_screen.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'album/album_item.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Provider.of<AlbumStore>(context, listen: false).refresh();
  }

  @override
  Widget build(BuildContext context) {
    AlbumStore _store = Provider.of<AlbumStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).album),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create album',
            onPressed: () => Navigator.of(context).pushNamed("/album/add"),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 200,
        showChildOpacityTransition: false,
        onRefresh: () => _store.refresh(),
        child: Observer(
          builder: (_) => _store.isLoading
              ? Loading()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.0),
                  itemCount: _store.data.length,
                  itemBuilder: (context, index) => AlbumItem(
                      _store.data[index].id, _store.data[index].name, 0),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        tooltip: 'Take photo',
        child: Icon(Icons.camera),
      ),
    );
  }

  Future<void> _takePhoto() async {
    final callback = ModalRoute.of(context).settings.name;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(
          callbackRoute: callback,
        ),
      ),
    );
  }
}
