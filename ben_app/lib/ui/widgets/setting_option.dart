import 'package:ben_app/common/crypto/protected_value.dart';
import 'package:ben_app/generated/l10n.dart';
import 'package:ben_app/ui/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

abstract class SettingOption extends StatelessWidget {
  final String _description;

  const SettingOption(this._description, {Key key}) : super(key: key);

  List<Widget> getFormFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(_description, style: Styles.descriptionStyle),
        ),
        ...getFormFields()
      ],
    );
  }
}

class SwitchOption extends SettingOption {
  final String _name;
  final WidgetBuilder _switchBuilder;

  SwitchOption(this._name, String description, this._switchBuilder)
      : super(description);

  @override
  List<Widget> getFormFields() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(_name),
          Observer(
            builder: _switchBuilder,
          ),
        ],
      )
    ];
  }
}

typedef bool ErrorPredict();
typedef String ErrorMessageProvider();

typedef void OnPasswordChanged(ProtectedValue value);

class PasswordSetting extends SettingOption {
  final OnPasswordChanged _onChangePassword;
  final OnPasswordChanged _onConfirmPassword;
  final ErrorPredict _errorPredict;
  final ErrorMessageProvider _errorMessageProvider;

  PasswordSetting(String description, this._onChangePassword,
      this._onConfirmPassword, this._errorPredict, this._errorMessageProvider)
      : super(description);

  @override
  List<Widget> getFormFields() {
    return <Widget>[
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: S.current.please_input_password),
        onChanged: (plain) => _onChangePassword(ProtectedValue.of(plain)),
      ),
      TextField(
        obscureText: true,
        decoration:
            InputDecoration(hintText: S.current.please_input_password_again),
        onChanged: (plain) => _onConfirmPassword(ProtectedValue.of(plain)),
      ),
      Observer(
        builder: (_) => _errorPredict.call()
            ? Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  _errorMessageProvider.call(),
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container(),
      ),
    ];
  }
}
