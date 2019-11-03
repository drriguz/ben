import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String _label;
  final Widget _child;

  const FormInput(this._label, this._child, {Key key}) : super(key: key);

  FormInput.textInput(this._label, String placeholder, {Key key})
      : _child = TextField(
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration.collapsed(hintText: placeholder),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              _label,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: _child,
          )
        ],
      ),
    );
  }
}
