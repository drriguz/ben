import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:ben_app/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'album/album_item.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumStore albumStore = Provider.of<AlbumStore>(context);
    albumStore.fetch();

    return Scaffold(
      appBar: AppBar(
        title: Text("相册"),
      ),
      body: Observer(
        builder: (_) => albumStore.isBusy ? Loading() : _createAlbumList(albumStore),
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
          crossAxisCount: 3, //每行三列
          childAspectRatio: 1.0 //显示区域宽高相等
          ),
      itemCount: albumStore.data.length,
      itemBuilder: (context, index) => AlbumItem(name: albumStore.data[index].meta.title, imageCount: 1),
    );
  }
}
