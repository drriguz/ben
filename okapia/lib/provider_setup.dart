import 'package:camera/camera.dart';
import 'package:okapia/common/sqlcipher/repository/note_repository.dart';
import 'package:okapia/services/note_service.dart';

import 'services/config_service.dart';
import 'package:provider/provider.dart';

import 'common/crypto/kdf.dart';
import 'services/login_service.dart';
import 'stores/note_store.dart';
import 'stores/user_store.dart';
import 'services/init_service.dart';

Future<List<SingleChildCloneableWidget>> _createStandaloneProviders() async {
  return [
    Provider<List<CameraDescription>>.value(value: await availableCameras()),
  ];
}

List<SingleChildCloneableWidget> _createRepositories() {
  return [
    Provider<NoteRepository>.value(value: new NoteRepository()),
  ];
}

final Kdf kdf = new Argon2Kdf();

List<SingleChildCloneableWidget> _createServices() {
  return [
    Provider<ConfigService>.value(value: new ConfigService()),
    ProxyProvider<NoteRepository, NoteService>(
        update: (_, noteRepository, service) => NoteService(noteRepository)),
    ProxyProvider<ConfigService, InitializeService>(
        update: (_, configService, service) =>
            InitializeService(configService)),
    ProxyProvider<ConfigService, LoginService>(
      update: (_, configService, service) => LoginService(configService),
    ),
  ];
}

/*
  to read: https://mobx.netlify.app/guides/stores
 */
List<SingleChildCloneableWidget> _createStores() {
  return [
    ProxyProvider<LoginService, UserStore>(
        update: (_, service, child) => UserStore(service)),
    ProxyProvider2<UserStore, NoteService, NoteStore>(
        update: (_, userStore, noteService, child) =>
            NoteStore(userStore, noteService)),
  ];
}

Future<List<SingleChildCloneableWidget>> createProviders() async {
  return [
    ...await _createStandaloneProviders(),
    ..._createRepositories(),
    ..._createServices(),
    ..._createStores(),
  ];
}
