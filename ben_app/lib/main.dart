import 'package:ben_app/service/init_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'format/sqlite/database_factory.dart';
import 'format/sqlite/sqlite_storage.dart';
import 'format/storage.dart';
import 'generated/i18n.dart';
import 'providers/view_models/login_model.dart';
import 'ui/page/Home.dart';
import 'ui/page/initialize.dart';
import 'ui/page/login.dart';

void main() async {
  final database =
      await SqliteFactory.createInstance("data.db", "assets/config/init.sql");
  final HeaderRepository headerRepository = SqliteHeaderRepository(database);
  final InitService initService = InitService(headerRepository);
  final bool hasInitialized = await initService.hasInitialized();

  final List<SingleChildCloneableWidget> providers = [
    // _independentServices,
    Provider.value(value: database),
    Provider.value(value: headerRepository),
    // _dependentServices,
    ProxyProvider<Database, SqliteItemRepository>(
      builder: (context, database, itemRepository) =>
          SqliteItemRepository(database),
    ),

    // _states
    ChangeNotifierProvider(builder: (context) => LoginViewModel()),
  ];

  runApp(AppEntry(
    providers: providers,
    hasInitialized: hasInitialized,
  ));
}

class AppEntry extends StatelessWidget {
  final bool hasInitialized;
  final List<SingleChildCloneableWidget> providers;

  const AppEntry({Key key, @required this.providers, this.hasInitialized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'ben',
        localizationsDelegates: const <
            LocalizationsDelegate<WidgetsLocalizations>>[
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          "/": (_) => hasInitialized ? new LoginPage() : new InitializePage(),
          "/login": (_) => new LoginPage(),
          "/home": (_) => new HomePage(),
        },
      ),
    );
  }
}
