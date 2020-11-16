import 'package:flutter/material.dart';
import 'package:okapia/ui/theme/icons.dart';

class Tag extends StatelessWidget {
  final String name;

  const Tag(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        children: [
          Icon(
            FontIcon.clock,
            color: Colors.grey,
            size: 20.0,
          ),
          Flexible(
            child: Text(name),
          ),
        ],
      ),
    );
  }
}
