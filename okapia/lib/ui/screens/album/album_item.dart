import 'package:flutter/material.dart';

class AlbumItem extends StatelessWidget {
  final int _id;
  final String _name;
  final int _imageCount;

  const AlbumItem(this._id, this._name, this._imageCount, {Key? key}) : super(key: key);

  static const TextStyle _labelStyle = TextStyle(color: Colors.white, fontSize: 18);
  static const TextStyle _subtitleStyle = TextStyle(color: Colors.white, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/album/detail", arguments: _id),
      child: Card(
        child: Stack(
          children: <Widget>[
            _createCover(),
            _createBackground(),
            _createTitles(),
          ],
        ),
      ),
    );
  }

  Widget _createCover() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/default_cover.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createBackground() {
    return Container(
      height: 350.0,
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(begin: FractionalOffset.topRight, end: FractionalOffset.bottomCenter, colors: [
            Colors.grey.withOpacity(0.0),
            Colors.black,
          ], stops: [
            0.0,
            1.0
          ])),
    );
  }

  Widget _createTitles() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$_imageCount", style: _subtitleStyle),
          Text(
            "$_name",
            style: _labelStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
