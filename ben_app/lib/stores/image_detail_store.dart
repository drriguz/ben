import 'package:ben_app/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'image_detail_store.g.dart';

class ImageDetailStore = _ImageDetailStore with _$ImageDetailStore;

abstract class _ImageDetailStore with Store {
  final UserStore _userStore;
  final ImageService _imageService;
  final String _id;

  @observable
  ImageProvider<dynamic> item;

  _ImageDetailStore(this._userStore, this._imageService, this._id);

  @action
  Future<void> fetch() {
    return _imageService
        .fetchImage(_id, _userStore.userCredential)
        .then((value) => item = MemoryImage(value.content.image));
  }
}
