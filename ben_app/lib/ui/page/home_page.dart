import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'secrets/item_list_page.dart';
import 'not_implemented.dart';

import '../theme/icons.dart';
import 'tabbed_list/tab_config.dart';
import 'tabbed_list/tabbed_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentPageIndex = 0;
  static final List<Widget> _tabItems = <Widget>[
    MultiProvider(
      providers:
          supportedTabs.map((config) => config.viewModelProvider()).toList(),
      child: TabbedListPage(),
    ),
    NotImplementedPage(title: 'Share'),
    NotImplementedPage(title: 'Settings'),
    NotImplementedPage(title: 'sync'),
  ];

  void _onTabActivate(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _tabItems.elementAt(_currentPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FontIcon.list), title: Text("私密")),
          BottomNavigationBarItem(icon: Icon(FontIcon.flag), title: Text("地标")),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.toolbox), title: Text("工具箱")),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.backup), title: Text("同步")),
        ],
        type: BottomNavigationBarType.fixed,
        // without this line tab icon won't display
        currentIndex: _currentPageIndex,
        onTap: _onTabActivate,
      ),
    );
  }
}
