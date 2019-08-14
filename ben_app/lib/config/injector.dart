typedef FactoryFunc<T> = T Function();

enum Scope {
  SINGLETON,
  LAZY_SINGLETON,
  ALWAYS_NEW,
}

class _ServiceProvider<T> {
  Scope scope;
  FactoryFunc creator;
  T instance;

  _ServiceProvider._internal(this.scope, this.creator, this.instance);

  factory _ServiceProvider.singleton(T instance) {
    assert(instance != null);
    return _ServiceProvider._internal(Scope.SINGLETON, null, instance);
  }

  factory _ServiceProvider.lazySingleton(FactoryFunc<T> creator) {
    assert(creator != null);
    return _ServiceProvider._internal(Scope.LAZY_SINGLETON, creator, null);
  }

  factory _ServiceProvider.alwaysNew(FactoryFunc<T> creator) {
    assert(creator != null);
    return _ServiceProvider._internal(Scope.ALWAYS_NEW, creator, null);
  }

  T get() {
    switch (scope) {
      case Scope.SINGLETON:
        return instance as T;
      case Scope.ALWAYS_NEW:
        return creator() as T;
      case Scope.LAZY_SINGLETON:
        if (instance == null) instance = creator();
        return instance as T;
    }
  }
}

class Injector {
  final _providers = new Map<Type, _ServiceProvider<dynamic>>();
  
  void registerSingleton<T>(T instance) {
    assert(!_providers.containsKey(T), "${T.toString()} already registered");
    _providers[T] = _ServiceProvider.singleton(instance);
  }

  void registerLazySingleton<T>(FactoryFunc<T> provider) {
    assert(!_providers.containsKey(T), "${T.toString()} already registered");
    _providers[T] = _ServiceProvider.lazySingleton(provider);
  }

  void registerAlwaysNew<T>(FactoryFunc<T> provider) {
    assert(!_providers.containsKey(T), "${T.toString()} already registered");
    _providers[T] = _ServiceProvider.alwaysNew(provider);
  }

  T get<T>() {
    _ServiceProvider<dynamic> provider = _providers[T];
    if (provider == null)
      throw new Exception('Unregistered type: ${T.toString()}');
    return provider.get();
  }
}
