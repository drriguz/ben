import 'package:flutter/material.dart';
import 'package:okapia/db/repository/note_repository.dart';
import 'package:okapia/services/config_service.dart';
import 'package:okapia/services/login_service.dart';
import 'package:okapia/services/note_service.dart';
import 'package:okapia/states/user_state.dart';
import 'package:okapia/ui/home_screen.dart';
import 'package:okapia/ui/login_screen.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'services/initialize_service.dart';
import 'states/note_state.dart';
import 'ui/initialize_screen.dart';
import 'ui/common/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hasInitialized = await ConfigService.isConfigExists();
  runApp(MultiProvider(
    providers: [
      Provider<ConfigService>.value(value: new ConfigService()),
      Provider<NoteRepository>.value(value: new NoteRepository()),
      ProxyProvider<ConfigService, InitializeService>(
        update: (_, configService, service) => InitializeService(configService),
      ),
      ProxyProvider<ConfigService, LoginService>(
        update: (_, configService, service) => LoginService(configService),
      ),
      ProxyProvider<NoteRepository, NoteService>(
        update: (_, repository, service) => NoteService(repository),
      ),
      ChangeNotifierProvider<UserState>(
        create: (_) => UserState(Provider.of(_, listen: false)),
      ),
      ChangeNotifierProvider<NotesState>(
        create: (_) => NotesState(
            Provider.of(_, listen: false), Provider.of(_, listen: false)),
      ),
    ],
    child: MaterialApp(
      title: "Okapia",
      theme: globalTheme,
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      routes: {
        "/": (_) => hasInitialized ? LoginScreen() : InitializeScreen(),
        "/home": (_) => HomeScreen(),
      },
    ),
  ));
}
