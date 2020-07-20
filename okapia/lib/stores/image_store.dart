import 'dart:io';

import 'package:okapia/common/format/image_data.dart';
import 'package:okapia/services/image_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'image_store.g.dart';

class ImageStore = _ImageStore with _$ImageStore;

abstract class _ImageStore extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final ImageService _imageService;
  final String _albumId;

  _ImageStore(this._userStore, this._imageService, this._albumId);

  @observable
  ObservableList<BriefImageData> data = ObservableList<BriefImageData>();

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _imageService
        .fetchImages(_albumId, _userStore.userCredential)
        .then((items) => data.addAll(items))
        .whenComplete(() => setIdle());
  }

  @action
  Future<void> create(File file) async {
    return _imageService
        .createImage(_albumId, file, _userStore.userCredential)
        .then((value) => data.add(BriefImageData.fromFullRecord(value)));
  }
}
