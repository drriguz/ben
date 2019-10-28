import 'package:ben_app/backend/mobx/item_list_store.dart';
import 'package:provider/provider.dart';

import '../../model/choice.dart';
import '../../theme/icons.dart';
import 'search_bar.dart';

import 'package:flutter/material.dart';

import 'tab_content_pages.dart';

class TabbedListPage extends StatefulWidget {
  @override
  State<TabbedListPage> createState() => _TabbedListPageState();
}

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('关于', 'about', Icons.directions_car),
  const MenuChoice('分享', 'share', Icons.directions_bus),
  const MenuChoice('反馈', 'feedback', Icons.directions_railway),
  const MenuChoice('偏好设置', 'settings', Icons.directions_walk),
  const MenuChoice('检查更新', 'update', Icons.directions_walk),
];

class _TabbedListPageState extends State<TabbedListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static const List<Tab> tabs = [
    const Tab(text: "记事"),
    const Tab(text: "卡片"),
    const Tab(text: "证件"),
  ];

  void _onPressed() {}

  void _onDropdownSelected(MenuChoice choice) {}

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar _createTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabs,
    );
  }

  TabBarView _createTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Consumer<NoteStore>(
          builder: (_, store, child) => NoteListPage(store),
        ),
        Consumer<BankcardStore>(
          builder: (_, store, child) => BankcardListPage(store),
        ),
        Consumer<CertificateStore>(
          builder: (_, store, child) => CertificateListPage(store),
        ),
      ],
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

  Future<void> _onAddPressed() async {
    dynamic data = await Navigator.of(context).pushNamed("/note/add");
  }
}
