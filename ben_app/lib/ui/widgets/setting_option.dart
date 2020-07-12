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

  SwitchOption(this._name, String description, this._switchBuilder) : super(description);

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

class PasswordSetting extends SettingOption {
  final Function _onChangePassword;
  final Function _onConfirmPassword;
  final ErrorPredict _errorPredict;
  final ErrorMessageProvider _errorMessageProvider;

  PasswordSetting(String description, this._onChangePassword, this._onConfirmPassword, this._errorPredict,
      this._errorMessageProvider)
      : super(description);

  @override
  List<Widget> getFormFields() {
    return <Widget>[
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: "请设置密码"),
        onChanged: _onChangePassword,
      ),
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: "请重新输入您的密码"),
        onChanged: _onConfirmPassword,
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
