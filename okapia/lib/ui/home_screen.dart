import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/ui/not_implemented.dart';

import 'icons.dart';
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  static final List<Widget> _tabItems = <Widget>[
    NotesScreen(),
    NotImplementedPage(),
    NotImplementedPage(),
    NotImplementedPage(),
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontIcon.list), label: S.of(context).label_notes),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.message), label: S.of(context).label_chat),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.calendar), label: S.of(context).label_minder),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.toolbox), label: S.of(context).label_tools),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onTabActivate,
      ),
    );
  }
}
