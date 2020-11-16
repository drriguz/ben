import 'package:flutter/material.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';

import '../widgets/list_item.dart';

class EventItem extends AbstractListItem {
  final EventModel model;

  EventItem(this.model, {Key key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Text(model.title);
  }

  @override
  void onClick(BuildContext context) async {
    Navigator.of(context).pushNamed("/event/detail", arguments: model.id);
  }
}
