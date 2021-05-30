import 'package:okapia/services/init_service.dart';
import 'package:okapia/stores/initialize_store.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/about.dart';
import 'widgets/finish_setup.dart';
import 'widgets/system_settings.dart';
import 'widgets/user_agreement.dart';

class InitializePage extends StatefulWidget {
  const InitializePage({Key? key}) : super(key: key);

  @override
  _InitializePageState createState() => _InitializePageState();
}

class _InitializePageState extends State<InitializePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  InitializeStore _store;

  _InitializePageState();

  @override
  void initState() {
    super.initState();
    _store = new InitializeStore(
        Provider.of<InitializeService>(context, listen: false));
    _tabController = new TabController(vsync: this, length: 4);
  }

  Widget _createBackground() {
    return Opacity(
      opacity: 0.8,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/green.jpeg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  static final tabNames = [
    S.current.about,
    S.current.settings,
    S.current.user_agreement,
    S.current.get_started,
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
                    SystemSettingsPage(_store,
                        onNext: this._onNextPage,
                        onPrevious: this._onPreviousPage),
                    UserAgreementPage(_store,
                        onNext: this._onNextPage,
                        onPrevious: this._onPreviousPage),
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
          //_createBackground(),
          _createTabs(),
        ],
      ),
    );
  }
}
