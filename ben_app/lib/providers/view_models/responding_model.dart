import 'package:flutter/material.dart';

enum State {
  BUSY,
  IDLE,
}

abstract class RespondingModel extends ChangeNotifier {
  RespondingModel(this._state);

  State _state;

  State get state => _state;

  set state(State value) {
    _state = value;
    notifyListeners();
  }

  bool get isBusy => _state == State.BUSY;
}
