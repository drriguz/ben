import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/password_detail_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/screens/password/display_password.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:okapia/ui/widgets/text_line.dart';
import 'package:provider/provider.dart';

import 'confirm_password.dart';

class PasswordDetailScreen extends StatefulWidget {
  final int id;

  const PasswordDetailScreen(this.id, {Key key}) : super(key: key);

  @override
  _PasswordDetailScreenState createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  PasswordDetailStore _store;

  @override
  void initState() {
    super.initState();
    _store = PasswordDetailStore(
      widget.id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<PasswordService>(context, listen: false),
    );
    _store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view_password_detail),
      ),
      body: Observer(
        builder: (_) => _store.isBusy
            ? Loading()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: _content(),
                ),
              ),
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLine(
          _store.data.name,
          name: S.of(context).name,
        ),
        TextLine(
          _store.data.account,
          name: S.of(context).account,
        ),
        TextLine(
          _store.data.url,
          name: S.of(context).login_url,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: _displayPassword,
                  child: Text(S.of(context).show_password),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _displayPassword() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => DisplayPasswordDialog(_store.data.content),
    );
    if (!confirmed) return;
  }
}
