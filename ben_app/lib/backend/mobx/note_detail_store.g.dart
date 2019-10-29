// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteDetailStore on _NoteDetailStore, Store {
  final _$_noteModelAtom = Atom(name: '_NoteDetailStore._noteModel');

  @override
  NoteModel get _noteModel {
    _$_noteModelAtom.context.enforceReadPolicy(_$_noteModelAtom);
    _$_noteModelAtom.reportObserved();
    return super._noteModel;
  }

  @override
  set _noteModel(NoteModel value) {
    _$_noteModelAtom.context.conditionallyRunInAction(() {
      super._noteModel = value;
      _$_noteModelAtom.reportChanged();
    }, _$_noteModelAtom, name: '${_$_noteModelAtom.name}_set');
  }

  final _$_NoteDetailStoreActionController =
      ActionController(name: '_NoteDetailStore');

  @override
  void setSelected(NoteModel model) {
    final _$actionInfo = _$_NoteDetailStoreActionController.startAction();
    try {
      return super.setSelected(model);
    } finally {
      _$_NoteDetailStoreActionController.endAction(_$actionInfo);
    }
  }
}
