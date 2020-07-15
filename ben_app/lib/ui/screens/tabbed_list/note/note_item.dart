import 'package:ben_app/backend/common/format/data/list_item_model.dart';
import 'package:ben_app/backend/common/format/data/note_model.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item.dart';

class NoteItem extends AbstractListItem {
  final ListItemModel<NoteMeta> model;

  NoteItem(this.model, {Key key}) : super(key: key);

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
              model.meta.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            model.meta.lastUpdatedTime?.toString() ?? "",
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  void onClick(BuildContext context) async{
    NoteStore store = Provider.of<NoteStore>(context, listen: false);
    print('got store:$store');
    Navigator.of(context).pushNamed("/note/detail", arguments: model);
  }
}
