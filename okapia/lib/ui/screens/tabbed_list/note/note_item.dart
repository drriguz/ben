import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okapia/common/sqlcipher/model/note.dart';
import 'package:okapia/ui/screens/tabbed_list/widgets/date_title.dart';
import 'package:okapia/ui/screens/tabbed_list/widgets/thumb_image.dart';

import '../widgets/list_item.dart';

class NoteItem extends AbstractListItem {
  final NoteModel model;
  static final timeFormat = new DateFormat.jm();
  static final dayOfWeekFormat = new DateFormat("EEEE");
  static final monthFormat = new DateFormat("MMM");

  NoteItem(this.model, {Key key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    final DateTime lastUpdated =
        DateTime.fromMillisecondsSinceEpoch(model.lastUpdatedTime);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DateTitle(lastUpdated),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _content(lastUpdated),
          ),
        ],
      ),
    );
  }

  Widget _content(DateTime lastUpdated) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              model.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          ThumbImage(),
        ],
      ),
    );
  }

  @override
  void onClick(BuildContext context) async {
    Navigator.of(context).pushNamed("/note/detail", arguments: model.id);
  }
}
