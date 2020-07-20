import 'common/sqlite/repository/album_repository.dart';
import 'common/sqlite/repository/image_repository.dart';
import 'common/sqlite/repository/structured_item_repository.dart';
import 'common/sqlite/repository/tile_repository.dart';
import 'services/album_service.dart';
import 'services/image_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'common/crypto/kdf.dart';
import 'common/sqlite/database_factory.dart';
import 'common/sqlite/repository/header_repository.dart';
import 'services/item_service.dart';
import 'services/login_service.dart';
import 'stores/album_store.dart';
import 'stores/note_store.dart';
import 'stores/user_store.dart';
import 'services/init_service.dart';

Future<List<SingleChildCloneableWidget>> _createStandaloneProviders() async {
  return [
    Provider<Database>.value(
        value: await SqliteFactory.createInstance(
            "data.db", "assets/config/init.sql")),
  ];
}

List<SingleChildCloneableWidget> _createComponents() {
  return [
    ProxyProvider<Database, HeaderRepository>(
        update: (_, database, repository) => HeaderRepository(database)),
    ProxyProvider<Database, StructuredItemRepository>(
        update: (_, database, repository) =>
            StructuredItemRepository(database)),
    ProxyProvider<Database, AlbumRepository>(
        update: (_, database, repository) => AlbumRepository(database)),
    ProxyProvider<Database, ImageRepository>(
        update: (_, database, repository) => ImageRepository(database)),
    ProxyProvider<Database, TileRepository>(
        update: (_, database, repository) => TileRepository(database)),
  ];
}

final Kdf kdf = new Argon2Kdf();

List<SingleChildCloneableWidget> _createServices() {
  return [
    ProxyProvider<HeaderRepository, InitializeService>(
        update: (_, headerRepository, service) =>
            InitializeService(headerRepository, kdf)),
    ProxyProvider<HeaderRepository, LoginService>(
      update: (_, repository, service) => LoginService(repository, kdf),
    ),
    ProxyProvider<StructuredItemRepository, ItemService>(
      update: (_, repository, service) => ItemService(repository, kdf),
    ),
    ProxyProvider<AlbumRepository, AlbumService>(
      update: (_, repository, service) => AlbumService(repository, kdf),
    ),
    ProxyProvider2<ImageRepository, TileRepository, ImageService>(
      update: (_, imageRepository, tileRepository, service) =>
          ImageService(imageRepository, tileRepository, kdf),
    ),
  ];
}

/*
  to read: https://mobx.netlify.app/guides/stores
 */
List<SingleChildCloneableWidget> _createStores() {
  return [
    ProxyProvider<LoginService, UserStore>(
        update: (_, service, child) => UserStore(service)),
    ProxyProvider2<UserStore, ItemService, NoteStore>(
        update: (_, userStore, itemService, child) =>
            NoteStore(userStore, itemService)),
    ProxyProvider2<UserStore, AlbumService, AlbumStore>(
        update: (_, userStore, albumService, child) =>
            AlbumStore(userStore, albumService)),
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
