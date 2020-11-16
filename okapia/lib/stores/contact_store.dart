import 'dart:io';

import 'package:okapia/common/sqlite/entity/contact_entity.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore extends PageStatusNotifier with Store {
  @observable
  ObservableList<ContactEntity> data = ObservableList<ContactEntity>();

  _ContactStore();

  @action
  Future<void> fetch() async {
    setBusy();
    data.clear();
  }
}
