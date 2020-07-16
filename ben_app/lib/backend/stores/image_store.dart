import 'dart:io';
import 'dart:math';

import 'package:ben_app/backend/common/format/data/image_model.dart';
import 'package:ben_app/backend/common/format/data_format.dart';
import 'package:ben_app/backend/common/format/serializer.dart';
import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/services/album_service.dart';
import 'package:flutter/material.dart';
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
  Future<void> create(PickedFile picked) async {

    return _albumService
        .createImage(_albumId, File(picked.path))
        .then((value) => createOrUpdateRawRecord(null, value));
  }
}
