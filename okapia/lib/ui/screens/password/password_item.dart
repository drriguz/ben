import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:okapia/ui/screens/reminder/widgets/list_item.dart';
import 'package:okapia/ui/theme/icons.dart';
import 'package:okapia/ui/theme/styles.dart';

import 'tag.dart';

class PasswordItem extends AbstractListItem {
  Widget _title(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          child: Center(
            child: Image.network(
              'https://github.com/favicon.ico',
              width: 48,
              height: 48,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                "淘宝Headline 6",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeDelta: -2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "solee.linux@gmail.com",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _tags() {
    return Row(
      children: [
        Tag("Photos", Icons.question_answer_outlined, Colors.green),
        Tag("Weak", Icons.warning_rounded, Colors.red),
      ],
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _title(context),
          ),
          Row(
            children: [
              Container(
                width: 60,
              ),
              Expanded(
                child: _tags(),
              ),
              Text("2020-10-23", style: Theme.of(context).textTheme.caption)
            ],
          )
        ],
      ),
    );
  }

  @override
  void onClick(BuildContext context) {
    // TODO: implement onClick
  }
}
