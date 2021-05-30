import 'package:flutter/material.dart';

abstract class AbstractListItem extends StatelessWidget {
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          borderOnForeground: false,
          margin: const EdgeInsets.only(top: 5.0),
          child: ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 70.0,
            ),
            child: buildContent(context),
          ),
        ),
      ),
    );
  }

  void onClick(BuildContext context);

  AbstractListItem({Key? key}) : super(key: key);
}

abstract class AbstractDataListItem<T> extends StatelessWidget {
  final T model;

  const AbstractDataListItem({Key? key, required this.model}) : super(key: key);

  ImageProvider getItemIcon();

  String getDescription();

  String getTitle();

  String getSubtitle();

  Widget buildDescription() {
    return Text(
      getDescription(),
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      margin: const EdgeInsets.only(top: 5.0),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 70.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              buildIcon(),
              Expanded(child: buildTitle(), flex: 1),
              Expanded(child: buildDescription(), flex: 1),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                color: Colors.deepOrange,
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
