import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/model/note.dart';

import '../widgets/list_item.dart';

class NoteItem extends AbstractListItem {
  final NoteModel model;

  NoteItem(this.model, {Key key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Observer(
          builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      model.title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    model.lastUpdatedTime?.toString() ?? "",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )),
    );
  }

  @override
  void onClick(BuildContext context) async {
    Navigator.of(context).pushNamed("/note/detail", arguments: model.id);
  }
}
