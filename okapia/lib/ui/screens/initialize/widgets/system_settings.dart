import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/stores/initialize_store.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/ui/widgets/setting_option.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';
import 'package:okapia/ui/widgets/text_input.dart';

class SystemSettingsPage extends StatefulWidget {
  final InitializeStore _store;
  final Function onPrevious;
  final Function onNext;

  const SystemSettingsPage(this._store,
      {Key key, @required this.onPrevious, @required this.onNext})
      : super(key: key);

  @override
  _SystemSettingsPageState createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  Widget build1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SwitchOption(
            S.of(context).enable_fingerprint,
            S.of(context).enable_fingerprint_description,
            (_) => Switch(
                value: widget._store.enableFingerPrint,
                onChanged: (value) =>
                    widget._store.setEnableFingerPrint(value)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: this.widget.onPrevious,
                child: Text(S.of(context).previous),
              ),
              Observer(
                builder: (_) => FlatButton(
                  onPressed: widget._store.isSettingsCompleted
                      ? this.widget.onNext
                      : null,
                  child: Text(S.of(context).next),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ProtectedValue _masterPassword;
  ProtectedValue _secondaryPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(S.of(context).master_password_description),
            TextInput(
              obscureText: true,
              mandatory: true,
              name: S.of(context).master_password,
              hint: S.of(context).master_password_hint,
              maxLength: 20,
              validator: (text) {
                if (text.length < 6) return S.of(context).password_too_short;
                return null;
              },
              onChanged: (text) {
                _masterPassword = ProtectedValue.of(text);
                print("set: $text");
              },
            ),
            TextInput(
              obscureText: true,
              name: S.of(context).confirm_master_password,
              maxLength: 20,
              validator: (text) {
                if (_masterPassword != null &&
                    _masterPassword.getText() != text)
                  return S.of(context).password_not_match;
                return null;
              },
            ),
            Text(S.of(context).secondary_password_description),
            TextInput(
              obscureText: true,
              name: S.of(context).secondary_password,
              hint: S.of(context).secondary_password_hint,
              maxLength: 6,
              onChanged: (text) {
                _secondaryPassword = ProtectedValue.of(text);
              },
              validator: (text) {
                if (text.length != 6)
                  return S.of(context).secondary_password_rule;
                return null;
              },
            ),
            TextInput(
              obscureText: true,
              name: S.of(context).confirm_secondary_password,
              maxLength: 6,
              validator: (text) {
                if (_secondaryPassword != null &&
                    _secondaryPassword.getText() != text)
                  return S.of(context).password_not_match;
                return null;
              },
            ),
            SwitchOption(
              S.of(context).enable_fingerprint,
              S.of(context).enable_fingerprint_description,
              (_) => Switch(
                  value: widget._store.enableFingerPrint,
                  onChanged: (value) =>
                      widget._store.setEnableFingerPrint(value)),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: this.widget.onPrevious,
                  child: Text(S.of(context).previous),
                ),
                FlatButton(
                  onPressed: _onNext,
                  child: Text(S.of(context).next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onNext() async {
    if (!_formKey.currentState.validate()) return;
    widget._store.setPasswords(_masterPassword, _secondaryPassword);
    return this.widget.onNext();
  }
}
