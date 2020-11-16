import 'package:okapia/generated/l10n.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/screens/tool_box_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'album_page.dart';
import 'contacts_page.dart';

import '../theme/icons.dart';
import 'tabbed_list/tabbed_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentPageIndex = 0;
  static final List<Widget> _tabItems = <Widget>[
    TabbedListPage(),
    AlbumPage(),
    ContactPage(),
    ToolboxPage(),
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
      UserStore _userStore = Provider.of<UserStore>(context);
      if (!_userStore.isPausedToTakePhoto) {
        _userStore.logout();
        Navigator.pushReplacementNamed(context, "/login");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _tabItems.elementAt(_currentPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontIcon.list), label: S.of(context).reminder),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.galley), label: S.of(context).photo),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.message), label: S.of(context).strongbox),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.toolbox), label: S.of(context).toolbox),
        ],
        type: BottomNavigationBarType.fixed,
        // without this line tab icon won't display
        currentIndex: _currentPageIndex,
        onTap: _onTabActivate,
      ),
    );
  }
}
