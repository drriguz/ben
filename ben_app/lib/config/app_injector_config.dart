import 'package:ben_app/persist/sqlite/repository_factory.dart';
import '../persist/repository.dart';
import '../logic/service/initialize_service.dart';

import 'injector.dart';

class InjectorHelper {
  static final Injector _injector = new Injector();

  static void registerClasses() async {
    _injector.registerSingleton<AbstractRepository>(
        await RepositoryFactory.createInstance());
    _injector.registerSingleton<InitializeService>(InitializeService());
  }

  static T get<T>() {
    return _injector.get<T>();
  }
}
