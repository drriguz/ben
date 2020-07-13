// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteDetailStore on _NoteDetailStore, Store {
  final _$noteDetailAtom = Atom(name: '_NoteDetailStore.noteDetail');

  @override
  RawRecord get noteDetail {
    _$noteDetailAtom.context.enforceReadPolicy(_$noteDetailAtom);
    _$noteDetailAtom.reportObserved();
    return super.noteDetail;
  }

  @override
  set noteDetail(RawRecord value) {
    _$noteDetailAtom.context.conditionallyRunInAction(() {
      super.noteDetail = value;
      _$noteDetailAtom.reportChanged();
    }, _$noteDetailAtom, name: '${_$noteDetailAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch(String id) {
    return _$fetchAsyncAction.run(() => super.fetch(id));
  }
}
