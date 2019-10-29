import 'package:ben_app/ui/model/note_model.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class NoteItem extends AbstractListItem {
  final NoteModel model;

  NoteItem({Key key, this.model});

  @override
  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              model.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            model.content,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
