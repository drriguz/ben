import 'package:ben_app/widgets/card.dart';

import '../theme/icons.dart';
import '../widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'not_implemented.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> menuItems = const <Choice>[
  const Choice(title: '关于', icon: Icons.directions_car),
  const Choice(title: '分享', icon: Icons.directions_bus),
  const Choice(title: '反馈', icon: Icons.directions_railway),
  const Choice(title: '偏好设置', icon: Icons.directions_walk),
  const Choice(title: '检查更新', icon: Icons.directions_walk),
];

const List<Choice> tabItems = const <Choice>[
  const Choice(title: '卡片'),
  const Choice(title: '证书'),
  const Choice(title: '媒体'),
  const Choice(title: '密码'),
  const Choice(title: '记事'),
  const Choice(title: '文本'),
];

class _ItemListPageState extends State<ItemListPage> {
  void _onPressed() {}

  void _onDropdownSelected(Choice choice) {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Stack(
            children: <Widget>[
              Center(
                child: SearchBar(),
              )
            ],
          ),
          actions: <Widget>[
            new IconButton(icon: Icon(FontIcon.backup), onPressed: _onPressed),
            new PopupMenuButton<Choice>(
              onSelected: _onDropdownSelected,
              itemBuilder: (BuildContext context) {
                return menuItems.map((Choice choice) {
                  return new PopupMenuItem<Choice>(
                    value: choice,
                    child: ListTile(
                      leading: Icon(choice.icon),
                      title: Text(choice.title),
                    ),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return CardListItem(title: "建设银行", subtitle: "9771");
            }));
  }
}
