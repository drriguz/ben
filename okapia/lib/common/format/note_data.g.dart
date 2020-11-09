// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BriefNoteData on _BriefNoteData, Store {
  final _$metaAtom = Atom(name: '_BriefNoteData.meta');

  @override
  NoteMetaMessage get meta {
    _$metaAtom.reportRead();
    return super.meta;
  }

  @override
  set meta(NoteMetaMessage value) {
    _$metaAtom.reportWrite(value, super.meta, () {
      super.meta = value;
    });
  }

  @override
  String toString() {
    return '''
meta: ${meta}
    ''';
  }
}
