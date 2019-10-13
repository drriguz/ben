import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'empty_list_tip.dart';
import 'list_item_placeholder.dart';

class SecretListWidget<M extends DataModel, T extends AbstractPlugin<M>>
    extends StatefulWidget {
  final T _plugin;

  const SecretListWidget({Key key, @required T plugin})
      : _plugin = plugin,
        super(key: key);

  @override
  _SecretListWidgetState createState() => _SecretListWidgetState(_plugin);
}

class _SecretListWidgetState<M extends DataModel, T extends AbstractPlugin<M>>
    extends State<SecretListWidget> with AutomaticKeepAliveClientMixin {
  final T _plugin;

  _SecretListWidgetState(this._plugin);

  @override
  void initState() {
    super.initState();
    // here is a bug
    // https://github.com/flutter/flutter/issues/27680
    Future.microtask(() {
      if (this.mounted) _onRefresh();
    });
  }

  Widget _buildList(List<Item> data) {
    return data.isEmpty
        ? EmptyListTipWidget(onRefresh: _onRefresh)
        : _buildNoneEmptyListContent(data);
  }

  Widget _buildNoneEmptyListContent(List<Item> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          print("building with data...:$index ${data[index].id}");
          return _createListItem(data[index]);
        });
  }

  Widget _createListItem(Item data) {
    return FutureBuilder<M>(
      future: _plugin.decode(data),
      builder: (BuildContext _, AsyncSnapshot<M> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _plugin.build(snapshot.data);
          default:
            return ItemPlaceholder();
        }
      },
    );
  }

  Future<void> _onRefresh() async {
    Provider.of<ItemListViewModel>(context, listen: false)
        .fetch(_plugin.pluginId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListViewModel>(
        builder: (_, viewModel, child) => viewModel.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _buildList(viewModel.data),
                onRefresh: _onRefresh,
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
