import 'package:ben_app/plugins/option.dart';
import 'package:ben_app/plugins/plugin_registry.dart';
import 'package:ben_app/providers/services/item_list_service.dart';
import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/secret_list.dart';
import 'package:provider/provider.dart';

import '../../model/choice.dart';
import '../../theme/icons.dart';
import 'widgets/search_bar.dart';

import 'package:flutter/material.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('关于', 'about', Icons.directions_car),
  const MenuChoice('分享', 'share', Icons.directions_bus),
  const MenuChoice('反馈', 'feedback', Icons.directions_railway),
  const MenuChoice('偏好设置', 'settings', Icons.directions_walk),
  const MenuChoice('检查更新', 'update', Icons.directions_walk),
];

class _ItemListPageState extends State<ItemListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static final tabNames = PluginRegistry.getTabNames();

  void _onPressed() {}

  void _onDropdownSelected(MenuChoice choice) {}

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabNames.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar _createTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabNames.map((_) => Tab(text: _.displayName)).toList(),
    );
  }

  Widget _createList(Option<int> choice) {
    print("rendering...${choice.displayName}");
    return ChangeNotifierProxyProvider<ItemListService, ItemListViewModel>(
      initialBuilder: (_) =>
          ItemListViewModel(Provider.of<ItemListService>(_, listen: false)),
      builder: (_, service, viewModel) => viewModel,
      child: SecretListWidget(plugin: PluginRegistry.getPlugin(choice.value)),
    );
  }

  TabBarView _createTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: tabNames.map((_) => _createList(_)).toList(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Stack(
        children: <Widget>[
          Center(
            child: SearchBar(),
          )
        ],
      ),
      bottom: _createTabBar(),
      actions: <Widget>[
        IconButton(icon: Icon(FontIcon.backup), onPressed: _onPressed),
        PopupMenuButton<MenuChoice>(
          onSelected: _onDropdownSelected,
          itemBuilder: (BuildContext context) {
            return menuItems.map((MenuChoice choice) {
              return PopupMenuItem<MenuChoice>(
                value: choice,
                child: ListTile(
                  leading: Icon(choice.icon),
                  title: Text(choice.displayName),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createTabBarView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        tooltip: 'Create item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _onAddPressed() {
    final selectedType = tabNames[_tabController.index];
    final plugin = PluginRegistry.getPlugin(selectedType.value);
    plugin.onCreatePressed(context);
  }
}
