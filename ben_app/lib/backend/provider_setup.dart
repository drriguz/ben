import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/sqlite/database_factory.dart';
import 'package:ben_app/format/sqlite/sqlite_storage.dart';
import 'package:camera/camera.dart';
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
    Provider<Database>.value(value: await SqliteFactory.createInstance("data.db", "assets/config/init.sql")),
    Provider<List<CameraDescription>>.value(value: await availableCameras())
  ];
}

List<SingleChildCloneableWidget> _createComponents() {
  return [
    ProxyProvider<Database, SqliteHeaderRepository>(
      create: (_) => SqliteHeaderRepository(),
      update: (_, database, repository) => repository..db = database,
    ),
    ProxyProvider<Database, SqliteItemRepository>(
      create: (_) => SqliteItemRepository(),
      update: (_, database, repository) => repository..db = database,
    ),
  ];
}

final Kdf kdf = new Argon2Kdf();

List<SingleChildCloneableWidget> _createServices() {
  return [
    ProxyProvider2<SqliteHeaderRepository, SqliteItemRepository, InitializeService>(
      update: (_, headerRepository, itemRepository, service) =>
          InitializeService(headerRepository, itemRepository, kdf),
    ),
    ProxyProvider<SqliteHeaderRepository, LoginService>(
      update: (_, repository, service) => LoginService(repository, kdf),
    ),
    ProxyProvider<SqliteItemRepository, ItemService>(
      update: (_, repository, service) => ItemService(repository, kdf),
    ),
    Provider<NoteService>(
      create: (_) => NoteService(),
    ),
  ];
}

List<SingleChildCloneableWidget> _createStores() {
  return [
    ProxyProvider<InitializeService, InitializeStore>(update: (_, service, child) => InitializeStore(service)),
    ProxyProvider<LoginService, UserStore>(update: (_, service, child) => UserStore(service)),
    ProxyProvider<ItemService, NoteStore>(update: (_, service, child) => NoteStore(service)),
    ProxyProvider<ItemService, BankcardStore>(update: (_, service, child) => BankcardStore(service)),
    ProxyProvider<ItemService, CertificateStore>(update: (_, service, child) => CertificateStore(service)),
    ProxyProvider<ItemService, NoteDetailStore>(update: (_, service, child) => NoteDetailStore(service)),
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
