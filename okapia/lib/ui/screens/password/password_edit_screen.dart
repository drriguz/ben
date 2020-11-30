import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/utils/strings.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/password_edit_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/utils/toast.dart';
import 'package:okapia/ui/widgets/text_input.dart';
import 'package:provider/provider.dart';

import 'confirm_password.dart';
import 'seconday_password_input_dialog.dart';

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
  Uint8List _icon;

  TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _store = PasswordEditStore(
      -1,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<PasswordService>(context, listen: false),
    );
    _urlController = TextEditingController();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).create_password),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () => _onConfirmPassword(context),
            child: Text(S.of(context).save),
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

  Widget _createEditor() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          TextInput(
            name: S.of(context).name,
            hint: S.of(context).password_name_hint,
            maxLength: 100,
            mandatory: true,
            onSaved: (text) => _name = text,
            prefixIcon: Observer(
              builder: (_) => _store.icon == null
                  ? Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 36,
                    )
                  : Image.memory(
                      _store.icon,
                      width: 48,
                      height: 48,
                    ),
            ),
          ),
          TextInput(
            name: S.of(context).account,
            hint: S.of(context).password_account_hint,
            maxLength: 100,
            onSaved: (text) => _account = text,
          ),
          TextInput(
            controller: _urlController,
            name: S.of(context).login_url,
            hint: S.of(context).password_url_hint,
            maxLength: 200,
            onSaved: (text) => _url = text,
            suffixIcon: _fetchIcon(),
            validator: (text) {
              if (text.isNotEmpty && !Strings.isValidUrl(text))
                return S.of(context).invalid_url;
              return null;
            },
          ),
          Divider(),
          _createTip(context),
          TextInput(
            name: S.of(context).password,
            obscureText: true,
            mandatory: true,
            maxLength: 50,
            onChanged: (text) => _password = ProtectedValue.of(text),
          ),
          TextInput(
            name: S.of(context).confirm_password,
            obscureText: true,
            mandatory: true,
            maxLength: 50,
            validator: (text) {
              if (_password != null && _password.getText() != text)
                return S.of(context).password_not_match;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _fetchIcon() {
    return IconButton(
      icon: const Icon(Icons.download_outlined),
      onPressed: onFetchPressed,
    );
  }

  Future<void> onFetchPressed() async {
    final url = _urlController.text;
    if (url.isEmpty || !Strings.isValidUrl(url)) {
      Toasts.showError(S.of(context).invalid_url);
      return;
    } else
      print(url);
    return _store.fetchIcon(url).catchError((e) {
      Toasts.showError(S.of(context).download_icon_failed);
    });
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

    final secondaryPassword = await showDialog<ProtectedValue>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SecondaryPasswordInputDialog(),
    );
    if (secondaryPassword == null) return;

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
        .create(_name, _account, _url, _password, _store.icon)
        .then((_) => Navigator.of(context).pop())
        .whenComplete(() => _scaffoldKey.currentState.hideCurrentSnackBar());
  }
}
