// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactStore on _ContactStore, Store {
  final _$dataAtom = Atom(name: '_ContactStore.data');

  @override
  ObservableList<ContactEntity> get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(ObservableList<ContactEntity> value) {
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
}
