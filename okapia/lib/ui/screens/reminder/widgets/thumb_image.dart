import 'package:flutter/material.dart';

class ThumbImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      //constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/green.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
