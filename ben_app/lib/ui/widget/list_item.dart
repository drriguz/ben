import 'package:flutter/material.dart';
import '../model/bank_card.dart';

abstract class AbstractListItem<T> extends StatelessWidget {
  final T model;
  final bool hasDescription;

  const AbstractListItem({Key key, this.model, this.hasDescription})
      : super(key: key);

  Widget buildIcon();

  Widget buildTitle();

  Widget buildDescription();

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      margin: const EdgeInsets.only(top: 5.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            buildIcon(),
            Expanded(
              child: buildTitle(),
              flex: 1,
            ),
            Expanded(
              child: buildDescription(),
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              color: Colors.deepOrange,
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
