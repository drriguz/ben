import 'package:ben_app/config/injector.dart';
import 'package:test/test.dart';

abstract class Base {
  int call();
}

class Impl1 implements Base {
  static int constructedCount = 0;

  Impl1() {
    constructedCount++;
  }

  @override
  int call() {
    return 1;
  }
}

class Impl2 implements Base {
  static int constructedCount = 0;

  Impl2() {
    constructedCount++;
  }

  @override
  int call() {
    return 2;
  }
}

class Impl3 extends Base {
  static int constructedCount = 0;

  Impl3() {
    constructedCount++;
  }

  @override
  int call() {
    return 3;
  }
}

void main() {
  test('Inject singlton', () {
    final injector = new Injector();
    Impl1.constructedCount = 0;
    Base instance = new Impl1();
    injector.registerSingleton<Base>(instance);

    var i1 = injector.get<Base>();
    var i2 = injector.get<Base>();
    expect(i1 is Base, true);
    expect(i1 is Impl1, true);
    expect(i2 is Base, true);
    expect(i1 == i2, true);
    expect(Impl1.constructedCount, 1);
  });

  test('Inject lazy singlton', () {
    final injector = new Injector();
    Impl1.constructedCount = 0;
    injector.registerLazySingleton<Base>(() => new Impl1());
    expect(Impl1.constructedCount, 0);
    var i1 = injector.get<Base>();
    var i2 = injector.get<Base>();
    expect(i1 is Base, true);
    expect(i1 is Impl1, true);
    expect(i2 is Base, true);
    expect(i1 == i2, true);
    expect(Impl1.constructedCount, 1);
  });

  test('Inject always new', () {
    final injector = new Injector();
    Impl1.constructedCount = 0;
    injector.registerAlwaysNew<Base>(() => new Impl1());

    var i1 = injector.get<Base>();
    var i2 = injector.get<Base>();
    var i3 = injector.get<Base>();
    expect(i1 is Base, true);
    expect(i2 is Base, true);
    expect(i3 is Base, true);
    expect(i1 == i2 || i1 == i3, false);
    expect(Impl1.constructedCount, 3);
  });

  test('Get unregistered type', () {
    final injector = new Injector();
    injector.registerAlwaysNew<Base>(() => new Impl1());

    try {
      var i1 = injector.get<Impl1>();
      fail('Should throw exception');
    } catch (e) {}
  });

  test('Duplicate register', () {
    final injector = new Injector();
    injector.registerAlwaysNew<Base>(() => new Impl1());

    try {
      injector.registerAlwaysNew<Base>(() => new Impl1());
      fail('Should throw exception');
    } catch (e) {}
  });
}
