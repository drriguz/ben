import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/providers/view_models/login_model.dart';
import 'package:ben_app/providers/view_models/tabbed_list_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/empty_list_tip.dart';
import 'package:ben_app/ui/page/secrets/widgets/list_item_placeholder.dart';
import 'package:ben_app/ui/page/tabbed_list/tab_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ItemListView<T extends AbstractTabbedListViewModel<T>,
    M extends Serializable> extends StatefulWidget {
  final TabConfig<T, M> config;

  const ItemListView({Key key, @required this.config}) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState<T, M>(config);
}

class _ItemListViewState<T extends AbstractTabbedListViewModel<T>,
    M extends Serializable> extends State<ItemListView> {
  final TabConfig<T, M> config;

  _ItemListViewState(this.config);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (this.mounted) _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
        builder: (_, viewModel, child) => viewModel.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _buildList(viewModel.data),
                onRefresh: _onRefresh,
              ));
  }

  Future<void> _onRefresh() async {
    Provider.of<T>(context, listen: false).fetch();
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
      future: Provider.of<T>(context, listen: false).decode(
          data.content,
          Provider.of<LoginViewModel>(context, listen: false).userCredential,
          config.modelConstructor),
      builder: (BuildContext _, AsyncSnapshot<M> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            print("=> decoded: ${snapshot.data}");
            return config.itemViewBuilder(snapshot.data);
          default:
            return ItemPlaceholder();
        }
      },
    );
  }
}
