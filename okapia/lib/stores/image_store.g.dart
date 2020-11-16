// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageStore on _ImageStore, Store {
  final _$dataAtom = Atom(name: '_ImageStore.data');

  @override
  ObservableList<ImageModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<ImageModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ImageStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$createAsyncAction = AsyncAction('_ImageStore.create');

  @override
  Future<void> create(File file) {
    return _$createAsyncAction.run(() => super.create(file));
  }

  @override
  String toString() {
    return '''
data: ${data}
    ''';
  }
}
