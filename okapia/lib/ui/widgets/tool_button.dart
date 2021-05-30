import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final double iconSize;
  final TextStyle labelStyle;

  const ToolButton(
      {Key? key,
      required this.onTap,
      required this.label,
      required this.icon,
      this.iconSize = 24,
      this.labelStyle = const TextStyle(fontSize: 12)})
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
              size: iconSize,
            ), // icon
            Text(
              label,
              style: labelStyle,
            ), // text
          ],
        ),
      ),
    );
  }
}
