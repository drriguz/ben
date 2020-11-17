import 'package:okapia/generated/l10n.dart';

import '../model/choice.dart';
import '../theme/icons.dart';

import 'package:flutter/material.dart';

import 'reminder/calendar/calendar_tab.dart';
import 'reminder/event/event_list_page.dart';
import 'reminder/note/note_list_page.dart';

class ReminderScreen extends StatefulWidget {
  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('关于', 'about', Icons.directions_car),
  const MenuChoice('分享', 'share', Icons.directions_bus),
  const MenuChoice('反馈', 'feedback', Icons.directions_railway),
  const MenuChoice('偏好设置', 'settings', Icons.directions_walk),
  const MenuChoice('检查更新', 'update', Icons.directions_walk),
];

class _TabConfig {
  final String name;
  final Widget tabContent;
  final String addRoute;

  _TabConfig(this.name, this.tabContent, this.addRoute);
}

final tabConfigs = [
  _TabConfig(
    S.current.note,
    NoteListPage(),
    "/note/add",
  ),
  _TabConfig(
    S.current.calendar,
    CalendarTabPage(),
    "/event/add",
  ),
  _TabConfig(
    S.current.event,
    EventListPage(),
    "/event/add",
  ),
];

class _ReminderScreenState extends State<ReminderScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs =
      tabConfigs.map((config) => Tab(text: config.name)).toList();

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
      children: tabConfigs.map((config) => config.tabContent).toList(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Text("Okapia™"),
      bottom: _createTabBar(),
      actions: <Widget>[
        IconButton(icon: Icon(FontIcon.search), onPressed: _onPressed),
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
    final route = tabConfigs[_tabController.index].addRoute;
    return Navigator.of(context).pushNamed(route);
  }
}
