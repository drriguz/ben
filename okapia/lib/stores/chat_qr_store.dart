
import 'package:okapia/services/chat_service.dart';
import 'package:okapia/stores/page_status_notifier.dart';
import 'package:mobx/mobx.dart';

import 'user_store.dart';

part 'chat_qr_store.g.dart';

class ChatQrStore = _ChatQrStore with _$ChatQrStore;

abstract class _ChatQrStore extends PageStatusNotifier with Store {
  final UserStore _userStore;
  final ChatService _chatService;

  @observable
  String myKey;

  _ChatQrStore(this._userStore, this._chatService);

  @action
  Future<void> fetch() async {
    setBusy();
//    final activeKey = await _chatService.getActiveKey(_userStore.userCredential);
//    myKey = activeKey.meta.publicKey;

    setIdle();
  }
}
