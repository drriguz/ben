import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:okapia/ui/screens/reminder/widgets/list_item.dart';
import 'package:okapia/ui/theme/styles.dart';

class PasswordItem extends AbstractListItem {
  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              "Google账号密码",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .merge(TextStyle(color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "solee.linux@gmail.com",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .merge(TextStyle(color: Colors.grey)),
            ),
          ),
          Text(
            "Created at 2020-10-23",
          ),
        ],
      ),
    );
  }

  @override
  void onClick(BuildContext context) {
    // TODO: implement onClick
  }
}
