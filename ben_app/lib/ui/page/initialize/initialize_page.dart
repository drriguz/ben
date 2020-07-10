import 'package:ben_app/backend/mobx/initialize_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/about.dart';
import 'widgets/finish_setup.dart';
import 'widgets/system_settings.dart';
import 'widgets/user_agreement.dart';

class InitializePage extends StatefulWidget {
  final InitializeStore _store;

  const InitializePage(this._store, {Key key}) : super(key: key);

  @override
  _InitializePageState createState() => _InitializePageState(_store);
}

class _InitializePageState extends State<InitializePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final InitializeStore _store;

  _InitializePageState(this._store);

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  Widget _createBackground() {
    return Opacity(
      opacity: 0.8,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/green.jpeg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  static const tabNames = ["了解难知", "系统设置", "用户协议", "开始使用"];

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
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("assets/title.png"),
            ),
            _createTabBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    AboutPage(onNext: this._onNextPage),
                    SystemSettingsPage(_store, onNext: this._onNextPage, onPrevious: this._onPreviousPage),
                    UserAgreementPage(onNext: this._onNextPage, onPrevious: this._onPreviousPage),
                    FinishSetupPage(_store),
                  ],
                ),
              ),
            ),
          ],
        ),
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
          _createBackground(),
          _createTabs(),
        ],
      ),
    );
  }
}
