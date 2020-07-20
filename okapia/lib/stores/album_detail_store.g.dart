// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumDetailStore on _AlbumDetailStore, Store {
  final _$_albumDataAtom = Atom(name: '_AlbumDetailStore._albumData');

  @override
  AlbumData get _albumData {
    _$_albumDataAtom.context.enforceReadPolicy(_$_albumDataAtom);
    _$_albumDataAtom.reportObserved();
    return super._albumData;
  }

  @override
  set _albumData(AlbumData value) {
    _$_albumDataAtom.context.conditionallyRunInAction(() {
      super._albumData = value;
      _$_albumDataAtom.reportChanged();
    }, _$_albumDataAtom, name: '${_$_albumDataAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }
}
