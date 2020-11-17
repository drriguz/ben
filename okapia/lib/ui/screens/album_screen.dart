import 'package:okapia/generated/l10n.dart';
import 'package:okapia/stores/album_store.dart';
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
  @override
  void initState() {
    super.initState();
    AlbumStore albumStore = Provider.of<AlbumStore>(context, listen: false);
    albumStore.fetch();
  }

  @override
  Widget build(BuildContext context) {
    AlbumStore albumStore = Provider.of<AlbumStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).album),
      ),
      body: Observer(
        builder: (_) =>
            albumStore.isBusy ? Loading() : _createAlbumList(albumStore),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/album/add"),
        tooltip: 'Take photo',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createAlbumList(AlbumStore albumStore) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.0),
      itemCount: albumStore.data.length,
      itemBuilder: (context, index) =>
          AlbumItem(albumStore.data[index].id, albumStore.data[index].name, 0),
    );
  }
}
