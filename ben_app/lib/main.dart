import 'package:ben_app/backend/mobx/note_detail_store.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/ui/page/tabbed_list/bankcard/add_bankcard.dart';
import 'package:ben_app/ui/page/tabbed_list/note/add_note_page.dart';
import 'package:ben_app/ui/page/tabbed_list/note/note_detail_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/mobx/item_list_store.dart';
import 'backend/mobx/user_store.dart';
import 'backend/provider_setup.dart';
import 'backend/services/init_check_service.dart';
import 'format/sqlite/database_factory.dart';
import 'format/sqlite/sqlite_storage.dart';
import 'generated/i18n.dart';
import 'ui/page/home_page.dart';
import 'ui/page/initialize/initialize_page.dart';
import 'ui/page/login_page.dart';
import 'ui/page/tabbed_list/bankcard/scan_card.dart';

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
          //fontFamily: 'fzltxh',
          primarySwatch: Colors.purple,
        ),
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
          "/note/add": (_) => Consumer3<NoteStore, UserStore, NoteService>(
                builder: (_, noteStore, userStore, noteService, child) =>
                    AddNotePage(noteStore, userStore, noteService),
              ),
          "/note/detail": (_) => Consumer<NoteDetailStore>(
                builder: (_, store, child) => NoteDetailPage(store),
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
