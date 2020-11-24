// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordStore<M> on _PasswordStore<M>, Store {
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount,
              name: '_PasswordStore.totalCount'))
          .value;

  final _$dataAtom = Atom(name: '_PasswordStore.data');

  @override
  ObservableList<PasswordModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<PasswordModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_PasswordStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$refreshAsyncAction = AsyncAction('_PasswordStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$fetchMoreAsyncAction = AsyncAction('_PasswordStore.fetchMore');

  @override
  Future<void> fetchMore() {
    return _$fetchMoreAsyncAction.run(() => super.fetchMore());
  }

  final _$updateAsyncAction = AsyncAction('_PasswordStore.update');

  @override
  Future<void> update(int id, String name, String account, String url,
      ProtectedValue password) {
    return _$updateAsyncAction
        .run(() => super.update(id, name, account, url, password));
  }

  final _$createAsyncAction = AsyncAction('_PasswordStore.create');

  @override
  Future<void> create(String title, String name, String account, String url,
      ProtectedValue password) {
    return _$createAsyncAction
        .run(() => super.create(title, name, account, url, password));
  }

  final _$deleteAsyncAction = AsyncAction('_PasswordStore.delete');

  @override
  Future<void> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
data: ${data},
isLoading: ${isLoading},
totalCount: ${totalCount}
    ''';
  }
}
