import 'package:test/test.dart';

class Foo<T> {
  T data;

  Foo(this.data);

}

void main() {
  print('~~~');
  Foo<int> f1 = Foo<int>(1);
  Foo<String> f2 = Foo<String>("hello world");
  List<Foo> foos = [f1, f2];

  final s = foos[0].data;
  print(s);
  test('get user crendential', () async {});
}
