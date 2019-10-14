import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  const ToolButton({Key key, @required this.onTap, this.label, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap: onTap, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 24,
            ), // icon
            Text(
              label,
              style: TextStyle(fontSize: 12),
            ), // text
          ],
        ),
      ),
    );
  }
}
