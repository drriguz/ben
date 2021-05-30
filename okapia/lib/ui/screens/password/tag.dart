import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final Color _iconColor;

  const Tag(this._title, this._icon, this._iconColor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            _icon,
            color: _iconColor,
            size: 14.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(_title, style: Theme.of(context).textTheme.caption.apply(fontSizeDelta: 1)),
        )
      ],
    );
  }
}
