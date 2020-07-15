import 'package:ben_app/ui/screens/album/edit_album_page.dart';
import 'package:ben_app/ui/screens/tabbed_list/note/edit_note_page.dart';
import 'package:ben_app/ui/screens/tabbed_list/note/note_detail_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/stores/user_store.dart';
import 'backend/provider_setup.dart';
import 'backend/common/services/init_check_service.dart';
import 'backend/common/format/data/list_item_model.dart';
import 'backend/common/format/data/note_model.dart';
import 'backend/common/format/sqlite/database_factory.dart';
import 'backend/common/format/sqlite/sqlite_storage.dart';
import 'generated/l10n.dart';
import 'ui/screens/home_page.dart';
import 'ui/screens/initialize/initialize_page.dart';
import 'ui/screens/login_page.dart';

Future<bool> checkInitialized() async {
  final database = await SqliteFactory.createInstance("data.db", "assets/config/init.sql");
  final InitializeCheckService checkService = InitializeCheckService(SqliteHeaderRepository()..db = database);
  final initialized = checkService.hasInitialized();
  await database.close();
  return initialized;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          //fontFamily: 'fzltxh',
          primarySwatch: Colors.purple,
        ),
        onGenerateRoute: (settings) {
          print('on generate route:${settings}');
          switch (settings.name) {
            case "/note/detail":
              {
                ListItemModel<NoteMeta> argument = settings.arguments;
                return MaterialPageRoute(builder: (context) => NoteDetailPage(argument.id));
              }
            case "/note/edit":
            case "/note/add":
              {
                String id = settings.arguments;
                return MaterialPageRoute(builder: (context) => EditNotePage(id));
              }
            case "/album/edit":
            case "/album/add":
              {
                String id = settings.arguments;
                return MaterialPageRoute(builder: (context) => EditAlbumPage(id));
              }
            default:
              break;
          }
          return null;
        },
        routes: {
          "/": (_) => initialized
              ? Consumer<UserStore>(
                  builder: (_, store, child) => LoginPage(store),
                )
              : InitializePage(),
          "/login": (_) => Consumer<UserStore>(
                builder: (_, store, child) => LoginPage(store),
              ),
          "/home": (_) => HomePage(),
        },
      ),
    ),
  );
}
