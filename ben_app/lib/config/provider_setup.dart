import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/format/sqlite/database_factory.dart';
import 'package:ben_app/format/sqlite/sqlite_storage.dart';
import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:ben_app/providers/view_models/login_model.dart';
import 'package:ben_app/service/init_service.dart';
import 'package:ben_app/service/item_list_service.dart';
import 'package:ben_app/service/login_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildCloneableWidget>> _createStandaloneProviders() async {
  return [
    Provider.value(
        value: await SqliteFactory.createInstance(
            "data.db", "assets/config/init.sql")),
  ];
}

Future<List<SingleChildCloneableWidget>> _createComponents() async {
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

Future<List<SingleChildCloneableWidget>> _createServices() async {
  return [
    ProxyProvider<SqliteHeaderRepository, InitializeService>(
      // todo: using constructor injection instead.
      initialBuilder: (_) => InitializeService(),
      builder: (_, repository, service) => service
        ..headerRepository = repository
        ..kdf = Argon2Kdf(),
    ),
    ProxyProvider<SqliteHeaderRepository, LoginService>(
      initialBuilder: (_) => LoginService(),
      builder: (_, repository, service) => service
        ..headerRepository = repository
        ..kdf = Argon2Kdf(),
    ),
    ProxyProvider<SqliteItemRepository, ItemListService>(
      initialBuilder: (_) => ItemListService(),
      builder: (_, repository, service) => service..itemRepository = repository,
    ),
  ];
}

Future<List<SingleChildCloneableWidget>> _createGlobalViewModels() async {
  return [
    ChangeNotifierProxyProvider<LoginService, LoginViewModel>(
      initialBuilder: (_) => LoginViewModel(),
      builder: (_, service, viewModel) => viewModel..loginService = service,
    ),
    ChangeNotifierProxyProvider<ItemListService, ItemListViewModel>(
      initialBuilder: (_) =>
          ItemListViewModel(Provider.of<ItemListService>(_, listen: false)),
      builder: (_, service, viewModel) => viewModel,
    ),
  ];
}

Future<List<SingleChildCloneableWidget>> createProviders() async {
  return [
    ...await _createStandaloneProviders(),
    ...await _createComponents(),
    ...await _createServices(),
    ...await _createGlobalViewModels(),
  ];
}
