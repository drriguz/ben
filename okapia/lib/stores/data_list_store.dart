import 'package:mobx/mobx.dart';

part 'data_list_store.g.dart';

abstract class DataListStore<T> = _DataListStore<T> with _$DataListStore<T>;

abstract class _DataListStore<T> with Store {
  @observable
  ObservableList<T> data = ObservableList<T>();

  @observable
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<List<T>> fetch();

  @action
  Future<void> refresh() async {
    _isLoading = true;
    data.clear();
    fetch().then((items) => data.addAll(items)).whenComplete(() {
      _isLoading = false;
    });
  }
}
