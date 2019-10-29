import 'package:flutter/material.dart';

import 'list_item.dart';

class ItemPlaceholder extends AbstractListItem {
  @override
  Widget buildContent(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
        Text("解密中...")
      ],
    );
  }

  @override
  void onClick(BuildContext context) {
    // do nothing
  }
}
