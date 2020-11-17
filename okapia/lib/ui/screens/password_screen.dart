import 'package:okapia/generated/l10n.dart';

import '../theme/icons.dart';

import 'package:flutter/material.dart';

import 'password/password_item.dart';

class PasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).password),
          actions: [
            IconButton(icon: Icon(FontIcon.search), onPressed: _onSearch),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: _itemBuilder,
        ));
  }

  Future<void> _onSearch() async {}

  Widget _itemBuilder(BuildContext context, int index) {
    return PasswordItem();
  }
}
