import 'dart:convert';
import 'dart:typed_data';

import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class LoadingImageItem extends StatelessWidget {
  LoadingImageItem(String id) : super(key: ValueKey(id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Loading(),
    );
  }
}

class ImageItem extends StatelessWidget {
  final int _id;
  final String _name;
  final Uint8List? _thumb;

  ImageItem(this._id, this._name, this._thumb, {Key? key})
      : super(key: ValueKey(_id));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed("/image/detail", arguments: _id),
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
          image: MemoryImage(_thumb!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
