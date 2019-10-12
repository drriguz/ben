import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/bank_card/bank_card.dart';
import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bank_card_item.dart';
import 'empty_list_tip.dart';

class SecretListWidget<T extends AbstractPlugin> extends StatefulWidget {
  final T _plugin;

  const SecretListWidget({Key key, @required T plugin})
      : _plugin = plugin,
        super(key: key);

  @override
  _SecretListWidgetState createState() =>
      _SecretListWidgetState(_plugin.pluginId);
}

class _SecretListWidgetState extends State<SecretListWidget> {
  final int _itemType;

  _SecretListWidgetState(this._itemType);

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _onRefresh());
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
          print("building...:$index");
          return BankCardItem(
            key: ObjectKey(index),
            model: BankCard(
                bank: 'ICBC',
                type: CardType.CREDIT,
                title: '$index',
                number: '6222005865412565805'),
          );
        });
  }

  Future<void> _onRefresh() async {
    print('refreshing...');
    Provider.of<ItemListViewModel>(context, listen: false).fetch(_itemType);
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
}
