import 'package:okapia/stores/event_store.dart';
import 'package:okapia/stores/note_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../widgets/empty_list_tip.dart';
import 'event_item.dart';

class EventListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _EventListPageState();
  }
}

class _EventListPageState extends State {
  ScrollController controller;

  @override
  void initState() {
    super.initState();

    final EventStore store = Provider.of<EventStore>(context, listen: false);
    store.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final EventStore store = Provider.of<EventStore>(context);
    return Observer(
      builder: (_) {
        return store.isBusy
            ? Center(child: CircularProgressIndicator())
            : NotificationListener<ScrollEndNotification>(
                onNotification: (e) => _onScrollEndNotification(store, e),
                child: RefreshIndicator(
                  child: _createList(store),
                  onRefresh: store.refresh,
                ),
              );
      },
    );
  }

  bool _onScrollEndNotification(
      EventStore store, ScrollEndNotification notification) {
    if (notification.depth != 0) return false;
    if (notification.metrics.axisDirection != AxisDirection.down) return false;
    if (notification.metrics.pixels < notification.metrics.maxScrollExtent)
      return false;
    store.fetchMore();
    return false;
  }

  Widget _createList(EventStore store) {
    if (store.totalCount == 0)
      return EmptyListTipWidget(onRefresh: store.refresh);
    return ListView.builder(
      itemCount: store.totalCount,
      itemBuilder: (_, int index) {
        return EventItem(store.data[index]);
      },
    );
  }
}
