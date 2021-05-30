import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'image_detail_store.g.dart';

class ImageDetailStore = _ImageDetailStore with _$ImageDetailStore;

abstract class _ImageDetailStore with Store {
  final UserStore _userStore;
  final int _id;

  @observable
  ImageProvider<dynamic>? item;

  _ImageDetailStore(this._userStore, this._id);

  @action
  Future<void> fetch() async {
//    final image =
//        await _imageService.fetchImage(_id, _userStore.userCredential);
//    return _imageService
//        .fetchImageData(image.content.tiles, _userStore.userCredential)
//        .then((bytes) => item = MemoryImage(bytes));
  }
}
