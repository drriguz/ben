import 'package:camera/camera.dart';
import 'package:okapia/common/sqlcipher/repository/event_repository.dart';
import 'package:okapia/common/sqlcipher/repository/note_repository.dart';
import 'package:okapia/common/sqlcipher/repository/password_repository.dart';
import 'package:okapia/services/album_service.dart';
import 'package:okapia/services/event_service.dart';
import 'package:okapia/services/image_service.dart';
import 'package:okapia/services/note_service.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/album_store.dart';
import 'package:okapia/stores/event_store.dart';
import 'package:okapia/stores/password_store.dart';

import 'common/sqlcipher/repository/album_repository.dart';
import 'common/sqlcipher/repository/image_repository.dart';
import 'services/config_service.dart';
import 'package:provider/provider.dart';

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
    Provider<EventRepository>.value(value: new EventRepository()),
    Provider<AlbumRepository>.value(value: new AlbumRepository()),
    Provider<ImageRepository>.value(value: new ImageRepository()),
    Provider<PasswordRepository>.value(value: new PasswordRepository()),
  ];
}

List<SingleChildCloneableWidget> _createServices() {
  return [
    Provider<ConfigService>.value(value: new ConfigService()),
    ProxyProvider<NoteRepository, NoteService>(
        update: (_, noteRepository, service) => NoteService(noteRepository)),
    ProxyProvider<EventRepository, EventService>(
        update: (_, eventRepository, service) => EventService(eventRepository)),
    ProxyProvider<AlbumRepository, AlbumService>(
        update: (_, repository, service) => AlbumService(repository)),
    ProxyProvider<ImageRepository, ImageService>(
        update: (_, repository, service) => ImageService(repository)),
    ProxyProvider<PasswordRepository, PasswordService>(
        update: (_, repository, service) => PasswordService(repository)),
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
      update: (_, service, child) => UserStore(service),
    ),
    ProxyProvider2<UserStore, NoteService, NoteStore>(
        update: (_, userStore, noteService, child) =>
            NoteStore(userStore, noteService)),
    ProxyProvider2<UserStore, EventService, EventStore>(
        update: (_, userStore, eventService, child) =>
            EventStore(userStore, eventService)),
    ProxyProvider2<UserStore, AlbumService, AlbumStore>(
        update: (_, userStore, albumService, child) =>
            AlbumStore(userStore, albumService)),
    ProxyProvider2<UserStore, PasswordService, PasswordStore>(
        update: (_, userStore, service, child) =>
            PasswordStore(userStore, service)),
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
