import 'dart:io';

import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:ben_app/backend/common/format/data/list_item_model.dart';
import 'package:ben_app/backend/common/format/data_format.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/services/album_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import 'item_list_store.dart';
import 'user_store.dart';

class ImageStore extends ItemListStore<ImageMeta, ImageData> {
  final String _albumId;
  final AlbumStore _albumStore;
  final AlbumService _albumService;

  ImageStore(UserStore userStore, this._albumStore, ItemService itemService,
      this._albumId, this._albumService)
      : super(
          userStore,
          itemService,
          TYPE_IMAGE,
          (meta) => Serializer.fromJson<ImageMeta>(
              meta, (_) => ImageMeta.fromJson(_)),
        ) {
    print('create store');
  }

  @action
  Future<void> createImage(PickedFile picked) async {
    final String id = _albumService.newId();
    final placeholder = ListItemModel(id, null);
    data.add(placeholder);
    ImageData image =
        await _albumService.createImage(_albumId, File(picked.path));
    print('image generated...}');
    return itemService
        .create(itemType, id, image, userStore.userCredential)
        .then((rawRecord) async {
      print('replacing...');
      data.remove(placeholder);
      data.add(await decodeMeta(rawRecord));
    });
  }
}
