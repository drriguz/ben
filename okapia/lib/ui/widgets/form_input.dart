import 'package:flutter/material.dart';

import 'setting_option.dart';

class FormInput extends SettingOption {
  final String _placeholder;
  final TextEditingController _controller;

  const FormInput(String description, this._placeholder, this._controller, {Key? key}) : super(description, key: key);

  @override
  List<Widget> getFormFields() {
    return <Widget>[
      TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: _placeholder),
      )
    ];
  }
}
