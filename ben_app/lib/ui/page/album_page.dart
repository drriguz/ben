import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("相册"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
          AlbumItem(name: "风景", imageCount: 1),
          AlbumItem(name: "人物", imageCount: 0),
          AlbumItem(name: "旅游", imageCount: 10),
          AlbumItem(name: "其他", imageCount: 10),
          AlbumItem(name: "系统", imageCount: 10),
          AlbumItem(name: "默认相册", imageCount: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTakePhotoPressed,
        tooltip: 'Take photo',
        child: Icon(Icons.photo_camera),
      ),
    );
  }

  void _onTakePhotoPressed() {}
}

class AlbumItem extends StatelessWidget {
  final String name;
  final int imageCount;

  const AlbumItem({Key key, this.name, this.imageCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/hlw.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 5,
              left: 5,
              child: Text("$name"),
            ),
            Positioned(
              bottom: 25,
              left: 5,
              child: Text("$imageCount"),
            )
          ],
        ),
      ),
    );
  }
}
