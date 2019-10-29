import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/sqlite/database_factory.dart';
import 'package:ben_app/format/sqlite/sqlite_storage.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'mobx/initialize_store.dart';
import 'mobx/item_list_store.dart';
import 'mobx/note_detail_store.dart';
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

final Kdf kdf = new Argon2Kdf();

List<SingleChildCloneableWidget> _createServices() {
  return [
    ProxyProvider2<SqliteHeaderRepository, SqliteItemRepository,
        InitializeService>(
      builder: (_, headerRepository, itemRepository, service) =>
          InitializeService(headerRepository, itemRepository, kdf),
    ),
    ProxyProvider<SqliteHeaderRepository, LoginService>(
      builder: (_, repository, service) => LoginService(repository, kdf),
    ),
    ProxyProvider<SqliteItemRepository, ItemService>(
      builder: (_, repository, service) => ItemService(repository, kdf),
    ),
    Provider<NoteService>(
      builder: (_) => NoteService(),
    ),
  ];
}

List<SingleChildCloneableWidget> _createStores() {
  return [
    ProxyProvider<InitializeService, InitializeStore>(
        builder: (_, service, child) => InitializeStore(service)),
    ProxyProvider<LoginService, UserStore>(
        builder: (_, service, child) => UserStore(service)),
    ProxyProvider<ItemService, NoteStore>(
        builder: (_, service, child) => NoteStore(service)),
    ProxyProvider<ItemService, BankcardStore>(
        builder: (_, service, child) => BankcardStore(service)),
    ProxyProvider<ItemService, CertificateStore>(
        builder: (_, service, child) => CertificateStore(service)),
    Provider<NoteDetailStore>(
      builder: (_) => NoteDetailStore(),
    )
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
