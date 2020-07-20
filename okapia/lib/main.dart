import 'ui/screens/album/album_detail_page.dart';
import 'ui/screens/album/edit_album_page.dart';
import 'ui/screens/album/image_detail_page.dart';
import 'ui/screens/tabbed_list/note/edit_note_page.dart';
import 'ui/screens/tabbed_list/note/note_detail_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/sqlite/database_factory.dart';
import 'common/sqlite/repository/header_repository.dart';
import 'stores/user_store.dart';
import 'provider_setup.dart';
import 'services/init_check_service.dart';
import 'generated/l10n.dart';
import 'ui/screens/home_page.dart';
import 'ui/screens/initialize/initialize_page.dart';
import 'ui/screens/login_page.dart';

Future<bool> checkInitialized() async {
  final database =
      await SqliteFactory.createInstance("data.db", "assets/config/init.sql");
  final InitializeCheckService checkService =
      InitializeCheckService(HeaderRepository(database));
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

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void startApp(bool initialized, List<SingleChildCloneableWidget> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        title: 'ben',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          //fontFamily: 'fzltxh',
          primarySwatch: Colors.indigo,
        ),
        onGenerateRoute: (settings) {
          print('on generate route:${settings}');
          switch (settings.name) {
            case "/note/detail":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => NoteDetailPage(id));
              }
            case "/note/edit":
            case "/note/add":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => EditNotePage(id));
              }
            case "/album/edit":
            case "/album/add":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => EditAlbumPage(id));
              }
            case "/album/detail":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => AlbumDetailPage(id));
              }
            case "/image/detail":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => ImageDetailPage(id));
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
