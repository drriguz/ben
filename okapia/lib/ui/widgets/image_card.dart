import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  ImageCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Card(
        child: Image.asset("assets/images/empty-image.png"),
      ),
    );
  }
}
