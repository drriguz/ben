import 'package:flutter/material.dart';
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
    NotImplementedPage(title: 'Settings'),
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
          BottomNavigationBarItem(icon: Icon(AliIcon.list), title: Text("记事")),
          BottomNavigationBarItem(icon: Icon(AliIcon.list), title: Text("隐私")),
          BottomNavigationBarItem(icon: Icon(AliIcon.group), title: Text("管理")),
          BottomNavigationBarItem(
              icon: Icon(AliIcon.toolbox), title: Text("工具箱")),
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
