import 'package:okapia/stores/note_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../widgets/empty_list_tip.dart';
import 'note_item.dart';

class NoteListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _NoteListPageState();
  }
}

class _NoteListPageState extends State {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);

    final NoteStore store = Provider.of<NoteStore>(context, listen: false);
    store.refresh();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteStore store = Provider.of<NoteStore>(context);
    return Observer(
      builder: (_) {
        return store.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _createList(store),
                onRefresh: store.refresh,
              );
      },
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      print("fire~~~");
    }
  }

  Widget _createList(NoteStore store) {
    if (store.totalCount == 0)
      return EmptyListTipWidget(onRefresh: store.refresh);
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      itemCount: store.totalCount,
      itemBuilder: (_, int index) {
        return NoteItem(store.data[index]);
      },
    );
  }
}
