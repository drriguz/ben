// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DataListStore<T> on _DataListStore<T>, Store {
  final _$dataAtom = Atom(name: '_DataListStore.data');

  @override
  ObservableList<T> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<T> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$_isLoadingAtom = Atom(name: '_DataListStore._isLoading');

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  final _$refreshAsyncAction = AsyncAction('_DataListStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  @override
  String toString() {
    return '''
data: ${data}
    ''';
  }
}
