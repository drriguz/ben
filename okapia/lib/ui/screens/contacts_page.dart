import 'package:okapia/stores/contact_store.dart';
import 'package:okapia/ui/model/choice.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'contacts/contact_item.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('出示二维码', 'show_profile', Icons.camera),
  const MenuChoice('更换秘钥', 'update_key', Icons.sync),
  const MenuChoice('复制我的口令', 'copy_public_key', Icons.content_copy),
];

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    ContactStore store = Provider.of<ContactStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("联系人"),
        actions: <Widget>[
          PopupMenuButton<MenuChoice>(
            onSelected: _onDropdownSelected,
            itemBuilder: (BuildContext context) {
              return menuItems.map((MenuChoice choice) {
                return PopupMenuItem<MenuChoice>(
                  value: choice,
                  child: ListTile(
                    leading: Icon(choice.icon),
                    title: Text(choice.displayName),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) => store.isBusy ? Loading() : _createContacts(store),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }

  Widget _createContacts(ContactStore store) {
    return ListView.builder(
      itemCount: store.data.length,
      itemBuilder: (context, index) => ContactItem(store.data[index]),
    );
  }

  Future<void> _onAdd() async {}

  @override
  void initState() {
    super.initState();
    ContactStore store = Provider.of<ContactStore>(context, listen: false);
    store.fetch();
  }

  void _onPressed() {}

  void _onDropdownSelected(MenuChoice choice) {
    switch (choice.value) {
      case 'show_profile':
        Navigator.of(context).pushNamed("/chat/profile");
        break;
    }
  }
}
