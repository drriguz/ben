// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumDetailStore on _AlbumDetailStore, Store {
  final _$_albumDataAtom = Atom(name: '_AlbumDetailStore._albumData');

  @override
  AlbumModel? get _albumData {
    _$_albumDataAtom.reportRead();
    return super._albumData;
  }

  @override
  set _albumData(AlbumModel? value) {
    _$_albumDataAtom.reportWrite(value, super._albumData, () {
      super._albumData = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_AlbumDetailStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
