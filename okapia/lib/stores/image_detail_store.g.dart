// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageDetailStore on _ImageDetailStore, Store {
  final _$itemAtom = Atom(name: '_ImageDetailStore.item');

  @override
  ImageProvider<dynamic>? get item {
    _$itemAtom.reportRead();
    return super.item;
  }

  @override
  set item(ImageProvider<dynamic>? value) {
    _$itemAtom.reportWrite(value, super.item, () {
      super.item = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ImageDetailStore.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  @override
  String toString() {
    return '''
item: ${item}
    ''';
  }
}
