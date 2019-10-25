// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_status_notifier.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageStatusNotifier on _PageStatusNotifier, Store {
  Computed<bool> _$isBusyComputed;

  @override
  bool get isBusy =>
      (_$isBusyComputed ??= Computed<bool>(() => super.isBusy)).value;

  final _$_stateAtom = Atom(name: '_PageStatusNotifier._state');

  @override
  State get _state {
    _$_stateAtom.context.enforceReadPolicy(_$_stateAtom);
    _$_stateAtom.reportObserved();
    return super._state;
  }

  @override
  set _state(State value) {
    _$_stateAtom.context.conditionallyRunInAction(() {
      super._state = value;
      _$_stateAtom.reportChanged();
    }, _$_stateAtom, name: '${_$_stateAtom.name}_set');
  }

  final _$_PageStatusNotifierActionController =
      ActionController(name: '_PageStatusNotifier');

  @override
  void setBusy() {
    final _$actionInfo = _$_PageStatusNotifierActionController.startAction();
    try {
      return super.setBusy();
    } finally {
      _$_PageStatusNotifierActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIdle() {
    final _$actionInfo = _$_PageStatusNotifierActionController.startAction();
    try {
      return super.setIdle();
    } finally {
      _$_PageStatusNotifierActionController.endAction(_$actionInfo);
    }
  }
}
