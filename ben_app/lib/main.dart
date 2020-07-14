import 'package:ben_app/backend/services/item_service.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/ui/page/tabbed_list/bankcard/add_bankcard.dart';
import 'package:ben_app/ui/page/tabbed_list/note/edit_note_page.dart';
import 'package:ben_app/ui/page/tabbed_list/note/note_detail_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/mobx/initialize_store.dart';
import 'backend/mobx/item_list_store.dart';
import 'backend/mobx/user_store.dart';
import 'backend/provider_setup.dart';
import 'backend/services/init_check_service.dart';
import 'format/model/list_item_model.dart';
import 'format/model/note_model.dart';
import 'format/sqlite/database_factory.dart';
import 'format/sqlite/sqlite_storage.dart';
import 'generated/l10n.dart';
import 'ui/page/home_page.dart';
import 'ui/page/initialize/initialize_page.dart';
import 'ui/page/login_page.dart';
import 'ui/page/tabbed_list/bankcard/scan_card.dart';

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
                ListItemModel<NoteMetaModel> argument = settings.arguments;
                return MaterialPageRoute(
                  builder: (context) {
                    return Consumer3<NoteStore, UserStore, ItemService>(
                      builder: (_, noteStore, userStore, itemService, child) =>
                          NoteDetailPage(argument.id, noteStore, userStore, itemService),
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
              : Consumer<InitializeStore>(builder: (_, store, child) => InitializePage(store)),
          "/login": (_) => Consumer<UserStore>(
                builder: (_, store, child) => LoginPage(store),
              ),
          "/home": (_) => HomePage(),
          "/note/add": (_) => Consumer3<NoteStore, UserStore, NoteService>(
                builder: (_, noteStore, userStore, noteService, child) =>
                    EditNotePage(noteStore, userStore, noteService),
              ),
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
