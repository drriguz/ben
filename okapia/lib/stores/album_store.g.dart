// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumStore on _AlbumStore, Store {
  final _$dataAtom = Atom(name: '_AlbumStore.data');

  @override
  ObservableList<AlbumModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<AlbumModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_AlbumStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$createAsyncAction = AsyncAction('_AlbumStore.create');

  @override
  Future<void> create(String name) {
    return _$createAsyncAction.run(() => super.create(name));
  }

  final _$updateAsyncAction = AsyncAction('_AlbumStore.update');

  @override
  Future<void> update(int id, String name) {
    return _$updateAsyncAction.run(() => super.update(id, name));
  }

  @override
  String toString() {
    return '''
data: ${data}
    ''';
  }
}
