import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:okapia/common/sqlcipher/repository.dart';
import 'package:okapia/stores/data_list_store.dart';

import 'loading.dart';

abstract class DataList<M extends Entity> extends StatelessWidget {
  final DataListStore<M> _store;

  const DataList(this._store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${_store.isLoading}");
    print("${_store.data}");
    return LiquidPullToRefresh(
      springAnimationDurationInMilliseconds: 200,
      showChildOpacityTransition: false,
      onRefresh: () => _store.refresh(),
      child: Observer(
        builder: (_) => _store.isLoading ? Loading() : _createList(),
      ),
    );
  }

  Widget createListItem(M item);

  Widget _createList() {
    return ListView.builder(
      itemCount: _store.data.length,
      itemBuilder: (_, int index) => createListItem(_store.data[index]),
    );
  }
}
