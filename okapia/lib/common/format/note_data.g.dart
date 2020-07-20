// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BriefNoteData on _BriefNoteData, Store {
  final _$metaAtom = Atom(name: '_BriefNoteData.meta');

  @override
  NoteMetaMessage get meta {
    _$metaAtom.context.enforceReadPolicy(_$metaAtom);
    _$metaAtom.reportObserved();
    return super.meta;
  }

  @override
  set meta(NoteMetaMessage value) {
    _$metaAtom.context.conditionallyRunInAction(() {
      super.meta = value;
      _$metaAtom.reportChanged();
    }, _$metaAtom, name: '${_$metaAtom.name}_set');
  }
}
