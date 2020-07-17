import 'package:ben_app/stores/user_store.dart';
import 'package:ben_app/ui/screens/tool_box_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'album_page.dart';
import 'not_implemented.dart';

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
    NotImplementedPage(title: 'talk'),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FontIcon.list), title: Text("私密")),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.galley), title: Text("相册")),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.message), title: Text("私聊")),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.toolbox), title: Text("工具箱")),
        ],
        type: BottomNavigationBarType.fixed,
        // without this line tab icon won't display
        currentIndex: _currentPageIndex,
        onTap: _onTabActivate,
      ),
    );
  }
}
