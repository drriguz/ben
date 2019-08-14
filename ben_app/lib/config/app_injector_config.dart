import 'injector.dart';

class AppInjector {
  static final Injector _injector = new Injector();

  static registerClasses() {

  }

  static T get<T>() {
    return _injector.get<T>();
  }
}
