import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:okapia/generated/l10n.dart';

import 'initialize/settings_page.dart';
import 'initialize/start_page.dart';
import 'initialize/about_page.dart';

import '../states/InitializationState.dart';

class InitializeScreen extends StatefulWidget {
  @override
  _InitializeScreenState createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  static final tabNames = [
    S.current.label_about,
    S.current.label_settings,
    S.current.label_get_started,
  ];

  Widget _createTabBar() {
    return IgnorePointer(
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.red,
        tabs: tabNames.map((tabName) => Tab(text: tabName)).toList(),
      ),
    );
  }

  Widget _createTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
      child: ChangeNotifierProvider<TabController>(
        create: (context) => _tabController,
        child: ChangeNotifierProvider<InitializationState>(
            create: (_) =>
                new InitializationState(Provider.of(_, listen: false)),
            child: Column(
              children: <Widget>[
                _createTabBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: <Widget>[
                        AboutPage(onNext: this._onNextPage),
                        SettingPage(
                            onPrevious: this._onPreviousPage,
                            onNext: this._onNextPage),
                        StartPage(),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _onPreviousPage() {
    _changeTab(-1);
  }

  void _onNextPage() {
    _changeTab(1);
  }

  void _changeTab(int movement) {
    int index = _tabController.index + movement;
    if (index >= 0 && index < tabNames.length) _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //_createBackground(),
          _createTabs(),
        ],
      ),
    );
  }
}
