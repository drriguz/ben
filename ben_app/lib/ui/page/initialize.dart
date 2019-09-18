import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/title.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/title.png"),
                    ),
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.red,
                      tabs: <Widget>[
                        Tab(
                          text: "了解难知",
                        ),
                        Tab(
                          text: "用户协议",
                        ),
                        Tab(
                          text: "系统设置",
                        ),
                        Tab(
                          text: "完成",
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
