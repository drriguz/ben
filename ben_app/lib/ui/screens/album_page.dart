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
        onPressed: () => Navigator.of(context).pushNamed("/album/add"),
        tooltip: 'Take photo',
        child: Icon(Icons.add),
      ),
    );
  }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("$name"),
            Text("$imageCount"),
          ],
        ),
      ),
    );
  }
}
