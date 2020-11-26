import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class TextLine extends StatelessWidget {
  final String name;
  final String value;

  const TextLine(this.value, {Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notAvailable = value == null || value.isEmpty;
    return TextFormField(
      initialValue: notAvailable ? S.of(context).not_available : value,
      style: notAvailable
          ? Theme.of(context).textTheme.bodyText1.apply(color: Colors.grey)
          : null,
      readOnly: true,
      maxLines: null,
      decoration: InputDecoration(
        labelText: name,
      ),
    );
  }
}
