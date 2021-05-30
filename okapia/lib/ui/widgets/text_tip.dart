import 'package:flutter/material.dart';

class TextTip extends StatelessWidget {
  final String _text;

  const TextTip(this._text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(_text, style: Theme.of(context).textTheme.subtitle1);
  }
}
