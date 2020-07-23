// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$contactAtom = Atom(name: '_ChatStore.contact');

  @override
  ContactEntity get contact {
    _$contactAtom.context.enforceReadPolicy(_$contactAtom);
    _$contactAtom.reportObserved();
    return super.contact;
  }

  @override
  set contact(ContactEntity value) {
    _$contactAtom.context.conditionallyRunInAction(() {
      super.contact = value;
      _$contactAtom.reportChanged();
    }, _$contactAtom, name: '${_$contactAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }
}
