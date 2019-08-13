import 'package:flutter/material.dart';
import '../debug/test_sqlite.dart';
import 'item_list.dart';
import 'not_implemented.dart';

import '../theme/icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  static final List<Widget> _tabItems = <Widget>[
    ItemListPage(),
    NotImplementedPage(title: 'Share'),
    NotImplementedPage(title: 'Settings'),
    DebugPage(),
  ];

  void _onTabActivate(int index) {
    setState(() {
      _currentPageIndex = index;
    });
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create item',
        child: Icon(Icons.add),
      ),
    );
  }
}
