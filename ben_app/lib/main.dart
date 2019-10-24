import 'package:ben_app/plugins/note/add_note_page.dart';
import 'package:ben_app/plugins/plugin_registry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/provider_setup.dart';
import 'providers/services/init_check_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'format/sqlite/database_factory.dart';
import 'format/sqlite/sqlite_storage.dart';
import 'generated/i18n.dart';
import 'ui/page/home_page.dart';
import 'ui/page/initialize/initialize_page.dart';
import 'ui/page/login_page.dart';

Future<bool> checkInitialized() async {
  final database =
      await SqliteFactory.createInstance("data.db", "assets/config/init.sql");
  final InitializeCheckService checkService =
      InitializeCheckService(SqliteHeaderRepository()..db = database);
  final initialized = checkService.hasInitialized();
  await database.close();
  return initialized;
}

void main() async {
  final bool hasInitialized = await checkInitialized();

  final List<SingleChildCloneableWidget> providers = await createProviders();

  print("starting app: initialized? $hasInitialized");
  startApp(hasInitialized, providers);
}

void startApp(bool initialized, List<SingleChildCloneableWidget> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'ben',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          "/": (_) => initialized ? new LoginPage() : new InitializePage(),
          "/login": (_) => new LoginPage(),
          "/home": (_) => new HomePage(),
          "/note/add": (_) => new AddNotePage(),
        },
      ),
    ),
  );
}
