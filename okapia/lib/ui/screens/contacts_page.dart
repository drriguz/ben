import 'package:fast_rsa/rsa.dart';
import 'package:okapia/stores/album_store.dart';
import 'package:okapia/stores/contact_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'album/album_item.dart';
import 'contacts/contact_item.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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

  Future<void> _onAdd() async {
    var result = await RSA.generate(2048);
    print(result.publicKey);
    print(result.privateKey);

    final e = await RSA.encryptPKCS1v15("helloworld", result.publicKey);
    final x = await RSA.decryptPKCS1v15(e, result.privateKey);

    print(e);
    print(x);
  }

  @override
  void initState() {
    super.initState();
    ContactStore store = Provider.of<ContactStore>(context, listen: false);
    store.fetch();
  }
}
