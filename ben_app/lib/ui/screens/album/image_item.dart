import 'dart:convert';

import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String _id;
  final String _name;
  final String _thumb;

  const ImageItem(this._id, this._name, this._thumb, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/Image/detail", arguments: _id),
      child: Card(
        child: Stack(
          children: <Widget>[
            _createCover(),
          ],
        ),
      ),
    );
  }

  Widget _createCover() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(base64.decode(_thumb)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
