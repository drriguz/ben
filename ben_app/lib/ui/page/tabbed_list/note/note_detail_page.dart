import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("查看记事"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            "to be done!",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
