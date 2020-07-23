import 'dart:io';

import 'package:okapia/common/format/image_data.dart';
import 'package:okapia/common/sqlite/entity/contact_entity.dart';
import 'package:okapia/common/sqlite/repository/contact_repository.dart';
import 'package:okapia/services/image_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore extends PageStatusNotifier with Store {
  final ContactRepository _repository;

  @observable
  ObservableList<ContactEntity> data = ObservableList<ContactEntity>();

  _ContactStore(this._repository);

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
    return _repository.getAll().then((items) => data.addAll(items)).whenComplete(() => setIdle());
  }
}
