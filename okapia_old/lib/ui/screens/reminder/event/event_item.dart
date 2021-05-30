import 'package:flutter/material.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/ui/screens/reminder/widgets/date_title.dart';

import '../widgets/list_item.dart';

class EventItem extends AbstractListItem {
  final EventModel model;

  EventItem(this.model, {Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTitle(DateTime.fromMillisecondsSinceEpoch(model.eventTime)),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              model.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClick(BuildContext context) async {
    Navigator.of(context).pushNamed("/event/detail", arguments: model.id);
  }
}
