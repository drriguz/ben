import 'package:flutter/material.dart';

class AlbumItem extends StatelessWidget {
  final String name;
  final int imageCount;

  const AlbumItem({Key key, this.name, this.imageCount}) : super(key: key);

  static const TextStyle _labelStyle = TextStyle(color: Colors.white, fontSize: 18);
  static const TextStyle _subtitleStyle = TextStyle(color: Colors.white, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/default_cover.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$imageCount", style: _subtitleStyle),
                Text(
                  "$name",
                  style: _labelStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
