import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  const CardListItem({this.title, this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[Text(title)],
    ));
  }
}
