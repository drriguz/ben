// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_edit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordEditStore on _PasswordEditStore, Store {
  final _$isSaveAbleAtom = Atom(name: '_PasswordEditStore.isSaveAble');

  @override
  bool get isSaveAble {
    _$isSaveAbleAtom.reportRead();
    return super.isSaveAble;
  }

  @override
  set isSaveAble(bool value) {
    _$isSaveAbleAtom.reportWrite(value, super.isSaveAble, () {
      super.isSaveAble = value;
    });
  }

  final _$downloadingAtom = Atom(name: '_PasswordEditStore.downloading');

  @override
  bool get downloading {
    _$downloadingAtom.reportRead();
    return super.downloading;
  }

  @override
  set downloading(bool value) {
    _$downloadingAtom.reportWrite(value, super.downloading, () {
      super.downloading = value;
    });
  }

  final _$iconAtom = Atom(name: '_PasswordEditStore.icon');

  @override
  Uint8List get icon {
    _$iconAtom.reportRead();
    return super.icon;
  }

  @override
  set icon(Uint8List value) {
    _$iconAtom.reportWrite(value, super.icon, () {
      super.icon = value;
    });
  }

  final _$fetchIconAsyncAction = AsyncAction('_PasswordEditStore.fetchIcon');

  @override
  Future<void> fetchIcon(String loginUrl) {
    return _$fetchIconAsyncAction.run(() => super.fetchIcon(loginUrl));
  }

  final _$createAsyncAction = AsyncAction('_PasswordEditStore.create');

  @override
  Future<void> create(String name, String account, String url,
      ProtectedValue password, Uint8List icon, TransformedKey secondaryKey) {
    return _$createAsyncAction.run(
        () => super.create(name, account, url, password, icon, secondaryKey));
  }

  @override
  String toString() {
    return '''
isSaveAble: ${isSaveAble},
downloading: ${downloading},
icon: ${icon}
    ''';
  }
}
