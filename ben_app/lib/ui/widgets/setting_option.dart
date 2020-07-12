import 'package:ben_app/ui/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

abstract class SettingOption extends StatelessWidget {
  final String _description;

  const SettingOption(this._description, {Key key}) : super(key: key);

  Widget getFormField();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(_description, style: Styles.descriptionStyle),
        ),
        getFormField()
      ],
    );
  }
}

class SwitchOption extends SettingOption {
  final String _name;
  final WidgetBuilder _switchBuilder;

  SwitchOption(this._name, String description, this._switchBuilder) : super(description);

  @override
  Widget getFormField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(_name),
        Observer(
          builder: _switchBuilder,
        ),
      ],
    );
  }
}
