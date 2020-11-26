import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class TextLine extends StatelessWidget {
  final String name;
  final String value;

  const TextLine(this.value, {Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      maxLines: null,
      decoration: InputDecoration(
        labelText: name,
        hintText: S.of(context).not_available,
      ),
    );
  }
}
