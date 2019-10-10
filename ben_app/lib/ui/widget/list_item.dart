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

abstract class GeneralIconItem<T> extends AbstractListItem<T> {
  const GeneralIconItem({Key key, T model})
      : super(key: key, model: model, hasDescription: true);

  ImageProvider getItemIcon();

  String getDescription();

  String getTitle();

  String getSubtitle();

  @override
  Widget buildDescription() {
    return Text(
      getDescription(),
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Image(
        image: getItemIcon(),
        width: 32,
        height: 32,
      ),
    );
  }

  @override
  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
          color: Colors.orange,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            getTitle(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            getSubtitle(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
