import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建新记事"),
      ),
      body: Center(child: const Text('创建新记事')),
    );
  }
}
