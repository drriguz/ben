import '../theme/icons.dart';
import '../widgets/search_bar.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class DropdownMenuItem {
  const DropdownMenuItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<DropdownMenuItem> menuItems = const <DropdownMenuItem>[
  const DropdownMenuItem(title: '关于', icon: Icons.directions_car),
  const DropdownMenuItem(title: '分享', icon: Icons.directions_bus),
  const DropdownMenuItem(title: '反馈', icon: Icons.directions_railway),
  const DropdownMenuItem(title: '偏好设置', icon: Icons.directions_walk),
  const DropdownMenuItem(title: '检查更新', icon: Icons.directions_walk),
];

class _ItemListPageState extends State<ItemListPage> {
  void _onPressed() {}

  void _onDropdownSelected(DropdownMenuItem choice) {}

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
            new IconButton(icon: Icon(AliIcon.help), onPressed: _onPressed),
            new PopupMenuButton<DropdownMenuItem>(
              onSelected: _onDropdownSelected,
              itemBuilder: (BuildContext context) {
                return menuItems.map((DropdownMenuItem choice) {
                  return new PopupMenuItem<DropdownMenuItem>(
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
              return Card(
                  child: ListTile(
                      leading: Icon(AliIcon.group),
                      title: Text('建设银行信用卡'),
                      trailing: Icon(AliIcon.settings)));
            }));
  }
}
