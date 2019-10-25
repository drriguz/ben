import 'package:mobx/mobx.dart';

part 'page_status_notifier.g.dart';

enum State {
  BUSY,
  IDLE,
}

class PageStatusNotifier = _PageStatusNotifier with _$PageStatusNotifier;

abstract class _PageStatusNotifier with Store {
  @observable
  State _state;

  State get state => _state;

  @computed
  bool get isBusy => _state == State.BUSY;

  @action
  void setBusy() => _state = State.BUSY;

  @action
  void setIdle() => _state = State.IDLE;
}
