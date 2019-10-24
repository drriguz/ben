import 'package:ben_app/plugins/bank_card/bank_card_model.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/util/strings.dart';
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
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text(
            "2019年8月10日",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
