import 'package:okapia/stores/album_store.dart';
import 'package:okapia/stores/contact_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'album/album_item.dart';
import 'contacts/contact_item.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    ContactStore store = Provider.of<ContactStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("联系人"),
      ),
      body: Observer(
        builder: (_) => store.isBusy ? Loading() : _createContacts(store),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createContacts(ContactStore store) {
    return ListView.builder(
      itemCount: store.data.length,
      itemBuilder: (context, index) => ContactItem(store.data[index]),
    );
  }

  @override
  void initState() {
    super.initState();
    ContactStore store = Provider.of<ContactStore>(context, listen: false);
    store.fetch();
  }
}
