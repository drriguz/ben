import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/backend/stores/item_detail_store.dart';
import 'package:ben_app/ui/screens/tabbed_list/bankcard/add_bankcard.dart';
import 'package:ben_app/ui/screens/tabbed_list/note/edit_note_page.dart';
import 'package:ben_app/ui/screens/tabbed_list/note/note_detail_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/stores/initialize_store.dart';
import 'backend/stores/item_list_store.dart';
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
import 'ui/screens/tabbed_list/bankcard/scan_card.dart';

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
                return MaterialPageRoute(
                  builder: (context) {
                    return Consumer<NoteDetailStore>(
                      builder: (_, store, child) => NoteDetailPage(argument.id, store),
                    );
                  },
                );
              }
            case "/note/edit":
            case "/note/add":
              {
                String id = settings.arguments;
                return MaterialPageRoute(
                  builder: (context) {
                    return Consumer<NoteStore>(
                      builder: (_, noteStore, child) => EditNotePage(noteStore, id),
                    );
                  },
                );
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
          "/bankcard/add": (_) => AddBankcardPage(),
          "/bankcard/scan": (_) => Consumer<List<CameraDescription>>(
                builder: (_, cameras, child) => ScanPage(
                  camera: cameras.first,
                ),
              ),
        },
      ),
    ),
  );
}
