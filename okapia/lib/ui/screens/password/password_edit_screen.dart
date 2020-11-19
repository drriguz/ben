import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class PasswordEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).create_password),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () => _onSave(context),
            child: Text(S.of(context).save),
          )
        ],
      ),
      body: _createEditor(context),
    );
  }

  Widget _createTip(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.info_outline,
            color: Colors.deepOrange,
            size: 18.0,
          ),
        ),
        Expanded(
          child: Text(
            S.of(context).public_fields,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }

  Widget _createEditor(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: S.of(context).please_input_password_title),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).please_input_account,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).please_input_url,
              ),
            ),
            Divider(),
            _createTip(context),
            TextField(
              obscureText: true,
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.deepOrange),
                  hintText: S.of(context).please_input_password),
            ),
            Center(
              child: FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.add,
                ),
                label: Text(S.of(context).add_photo),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onSave(BuildContext context) async {}
}
