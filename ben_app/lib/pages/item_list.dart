import '../modes/choice.dart';
import '../widgets/card.dart';
import '../theme/icons.dart';
import '../widgets/search_bar.dart';

import 'package:flutter/material.dart';

import 'not_implemented.dart';

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

const List<TabChoice> tabItems = const <TabChoice>[
  const TabChoice('卡片', SecretListType.CARD),
  const TabChoice('证书', SecretListType.CERTIFICATE),
  const TabChoice('媒体', SecretListType.MEDIA),
  const TabChoice('密码', SecretListType.PASSWORD),
  const TabChoice('记事', SecretListType.NOTE),
  const TabChoice('文件', SecretListType.FILE),
];

class _ItemListPageState extends State<ItemListPage> {
  void _onPressed() {}

  void _onDropdownSelected(MenuChoice choice) {}

  TabBar _createTabBar() {
    return TabBar(
        tabs: tabItems.map((TabChoice tabItem) {
      return new Tab(text: tabItem.option);
    }).toList());
  }

  Widget _createList(TabChoice choice) {
    if (choice.value == SecretListType.CARD)
      return ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return CardListItem(title: "建设银行", subtitle: "9771");
          });
    return NotImplementedPage(title: choice.option);
  }

  TabBarView _createTabBarView() {
    return TabBarView(
        children: tabItems.map((TabChoice tabItem) {
      return _createList(tabItem);
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabItems.length,
        child: Scaffold(
          appBar: AppBar(
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
                        title: Text(choice.option),
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: _createTabBarView(),
        ));
  }
}
