import 'package:ben_app/format/sqlite/sqlite_storage.dart';
import 'package:ben_app/format/storage.dart';
import 'package:sqflite/sqflite.dart';

import '../format/sqlite/database_factory.dart';
import 'package:provider/provider.dart';

import 'view_models/login_model.dart';

final List<SingleChildCloneableWidget> providers = [
  // _independentServices,
  FutureProvider.value(
      value: SqliteFactory.createInstance("data.db", "assets/config/init.sql")),
  // _dependentServices,
  ProxyProvider<Database, HeaderRepository>(
    builder: (context, database, headerRepository) =>
        SqliteHeaderRepository(database),
  ),

  // _states
  ChangeNotifierProvider(builder: (context) => LoginViewModel()),
];
