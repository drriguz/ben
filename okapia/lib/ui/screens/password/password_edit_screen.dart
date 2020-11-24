import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/password_edit_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/text_input.dart';
import 'package:provider/provider.dart';

import 'confirm_password.dart';

class PasswordEditScreen extends StatefulWidget {
  @override
  _PasswordEditScreenState createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  PasswordEditStore _store;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name;
  String _account;
  String _url;
  ProtectedValue _password;

  @override
  void initState() {
    super.initState();
    _store = PasswordEditStore(
      -1,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<PasswordService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).create_password),
        actions: [
          Observer(
            builder: (_) => FlatButton(
              textColor: Colors.white,
              onPressed:
                  _store.isSaveAble ? () => _onConfirmPassword(context) : null,
              child: Text(S.of(context).save),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _createEditor(),
        ),
      ),
    );
  }

  Future<void> _validate() async {
    _store.isSaveAble = _formKey.currentState.validate();
  }

  Widget _createEditor() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextInput(
            name: S.of(context).name,
            hint: S.of(context).password_name_hint,
            maxLength: 20,
            mandatory: true,
            onChanged: (_) => _validate(),
            onSaved: (text) => _name = text,
          ),
          TextInput(
            name: S.of(context).account,
            hint: S.of(context).password_account_hint,
            maxLength: 50,
            onChanged: (_) => _validate(),
            onSaved: (text) => _account = text,
          ),
          TextInput(
            name: S.of(context).login_url,
            hint: S.of(context).password_url_hint,
            maxLength: 100,
            onChanged: (_) => _validate(),
            onSaved: (text) => _url = text,
          ),
          Divider(),
          _createTip(context),
          TextInput(
            name: S.of(context).password,
            obscureText: true,
            mandatory: true,
            maxLength: 50,
            onChanged: (_) => _validate(),
            onSaved: (text) => _password = ProtectedValue.of(text),
          ),
        ],
      ),
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

  Future<void> _onConfirmPassword(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmPasswordDialog(_password),
    );
    if (!confirmed) return;

    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Theme.of(context).backgroundColor,
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          new Text(S.of(context).saving),
        ],
      ),
    ));
    return _store
        .create(_name, _account, _url, _password)
        .then((_) => Navigator.of(context).pop())
        .whenComplete(() => _scaffoldKey.currentState.hideCurrentSnackBar());
  }
}
