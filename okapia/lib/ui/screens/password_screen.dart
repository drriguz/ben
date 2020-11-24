import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/stores/data_list_store.dart';
import 'package:okapia/stores/password_list_store.dart';
import 'package:okapia/stores/password_store.dart';
import 'package:okapia/ui/widgets/data_list.dart';
import 'package:provider/provider.dart';

import '../theme/icons.dart';

import 'package:flutter/material.dart';

import 'password/password_item.dart';

class PasswordList extends DataList<PasswordModel> {
  PasswordList(DataListStore<PasswordModel> store) : super(store);

  @override
  Widget createListItem(PasswordModel item) {
    return PasswordItem(item);
  }
}

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PasswordListStore>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    PasswordListStore store = Provider.of<PasswordListStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).password),
        actions: [
          IconButton(icon: Icon(FontIcon.search), onPressed: _onSearch),
        ],
      ),
      body: PasswordList(store),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        tooltip: 'Create item',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _onSearch() async {}

  Future<void> _onAddPressed() async {
    return Navigator.of(context).pushNamed("/password/add");
  }
}
