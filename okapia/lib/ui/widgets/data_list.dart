import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:okapia/common/sqlcipher/repository.dart';
import 'package:okapia/stores/data_list_store.dart';

import 'loading.dart';

abstract class DataList<M extends Entity> extends StatelessWidget {
  final DataListStore<M> _store;
  final String Function(M object) groupBy;

  const DataList(this._store, {Key key, this.groupBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      springAnimationDurationInMilliseconds: 200,
      showChildOpacityTransition: false,
      onRefresh: () => _store.refresh(),
      child: Observer(
        builder: (_) => _store.isLoading ? Loading() : _createList(context),
      ),
    );
  }

  Widget createListItem(M item);

  Widget _createList(BuildContext context) {
    if (groupBy != null) return _createGroupedList(context);
    return ListView.builder(
      itemCount: _store.data.length,
      itemBuilder: (_, int index) => createListItem(_store.data[index]),
    );
  }

  Widget _createGroupedList(BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: _store.data,
      groupBy: (element) => groupBy(element),
      groupSeparatorBuilder: (name) => _separator(context, name),
      itemBuilder: (context, dynamic element) => createListItem(element),
      order: GroupedListOrder.ASC,
    );
  }

  Widget _separator(BuildContext context, String groupName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
      child: Text(
        groupName,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6.apply(fontSizeDelta: -2),
      ),
    );
  }
}
