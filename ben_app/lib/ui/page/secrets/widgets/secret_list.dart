import 'package:ben_app/plugins/bank_card/bank_card.dart';
import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bank_card_item.dart';

class SecretListWidget extends StatefulWidget {
  @override
  _SecretListWidgetState createState() => _SecretListWidgetState();
}

class _SecretListWidgetState extends State<SecretListWidget> {
  Widget _buildList() {
    return ListView.builder(
        itemCount: 100,
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
    Provider.of<ItemListViewModel>(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListViewModel>(
        builder: (_, viewModel, child) => viewModel.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _buildList(),
                onRefresh: _onRefresh,
              ));
  }
}
