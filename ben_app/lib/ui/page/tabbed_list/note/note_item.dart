import 'package:ben_app/backend/mobx/note_detail_store.dart';
import 'package:ben_app/ui/model/note_model.dart';
import 'package:flutter/material.dart';

import '../widget/list_item.dart';

class NoteItem extends AbstractListItem {
  final NoteModel model;
  final NoteDetailStore _detailStore;

  NoteItem(this._detailStore, this.model, {Key key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
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

  @override
  void onClick(BuildContext context) {
    _detailStore.setSelected(model);
    Navigator.of(context).pushNamed("/note/detail");
  }
}
