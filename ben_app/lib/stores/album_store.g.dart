// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumStore on _AlbumStore, Store {
  final _$dataAtom = Atom(name: '_AlbumStore.data');

  @override
  ObservableList<AlbumData> get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(ObservableList<AlbumData> value) {
    _$dataAtom.context.conditionallyRunInAction(() {
      super.data = value;
      _$dataAtom.reportChanged();
    }, _$dataAtom, name: '${_$dataAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$createAsyncAction = AsyncAction('create');

  @override
  Future<void> create(String name) {
    return _$createAsyncAction.run(() => super.create(name));
  }
}
