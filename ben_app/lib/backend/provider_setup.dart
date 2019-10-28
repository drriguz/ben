import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/sqlite/database_factory.dart';
import 'package:ben_app/format/sqlite/sqlite_storage.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'mobx/initialize_store.dart';
import 'mobx/item_list_store.dart';
import 'mobx/user_store.dart';
import 'services/init_service.dart';
import 'services/item_service.dart';
import 'services/login_service.dart';

Future<List<SingleChildCloneableWidget>> _createStandaloneProviders() async {
  return [
    Provider.value(
        value: await SqliteFactory.createInstance(
            "data.db", "assets/config/init.sql")),
  ];
}

List<SingleChildCloneableWidget> _createComponents() {
  return [
    ProxyProvider<Database, SqliteHeaderRepository>(
      initialBuilder: (_) => SqliteHeaderRepository(),
      builder: (_, database, repository) => repository..db = database,
    ),
    ProxyProvider<Database, SqliteItemRepository>(
      initialBuilder: (_) => SqliteItemRepository(),
      builder: (_, database, repository) => repository..db = database,
    ),
  ];
}

List<SingleChildCloneableWidget> _createServices() {
  return [
    ProxyProvider2<SqliteHeaderRepository, SqliteItemRepository,
        InitializeService>(
      // todo: using constructor injection instead.
      initialBuilder: (_) => InitializeService(),
      builder: (_, headerRepository, itemRepository, service) => service
        ..headerRepository = headerRepository
        ..itemRepository = itemRepository
        ..kdf = Argon2Kdf(),
    ),
    ProxyProvider<SqliteHeaderRepository, LoginService>(
      initialBuilder: (_) => LoginService(),
      builder: (_, repository, service) => service
        ..headerRepository = repository
        ..kdf = Argon2Kdf(),
    ),
    ProxyProvider<SqliteItemRepository, ItemService>(
      initialBuilder: (_) => ItemService(),
      builder: (_, repository, service) => service..itemRepository = repository,
    ),
  ];
}

List<SingleChildCloneableWidget> _createStores() {
  return [
    ProxyProvider<InitializeService, InitializeStore>(
      builder: (_, service, child) => InitializeStore(service),
    ),
    ProxyProvider<LoginService, UserStore>(
      builder: (_, service, child) => UserStore(service),
    ),
    ProxyProvider<ItemService, NoteStore>(
      builder: (_, service, child) => NoteStore(service),
    ),
    ProxyProvider<ItemService, BankcardStore>(
      builder: (_, service, child) => BankcardStore(service),
    ),
    ProxyProvider<ItemService, CertificateStore>(
      builder: (_, service, child) => CertificateStore(service),
    ),
  ];
}

Future<List<SingleChildCloneableWidget>> createProviders() async {
  return [
    ...await _createStandaloneProviders(),
    ..._createComponents(),
    ..._createServices(),
    ..._createStores(),
  ];
}
