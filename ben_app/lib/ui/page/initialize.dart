import 'package:flutter/material.dart';

import 'component/about.dart';

class InitializePage extends StatefulWidget {
  @override
  _InitializePageState createState() => _InitializePageState();
}

class _InitializePageState extends State<InitializePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  static const tabNames = ["了解难知", "系统设置", "用户协议", "完成"];

  Widget _createTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.red,
      tabs: tabNames.map((tabName) => Tab(text: tabName)).toList(),
    );
  }

  Widget _createTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0, left: 20, right: 20),
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
                controller: _tabController,
                children: <Widget>[
                  AboutPage(),
                  Text('2'),
                  Text('3'),
                  Text('4'),
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("上一步"),
              ),
              FlatButton(
                child: Text("下一步"),
              ),
            ],
          ),
        ],
      ),
    );
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
