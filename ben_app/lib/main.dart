import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/provider_setup.dart';
import 'service/init_check_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'format/sqlite/database_factory.dart';
import 'format/sqlite/sqlite_storage.dart';
import 'generated/i18n.dart';
import 'ui/page/Home.dart';
import 'ui/page/initialize.dart';
import 'ui/page/login.dart';

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
        },
      ),
    ),
  );
}
