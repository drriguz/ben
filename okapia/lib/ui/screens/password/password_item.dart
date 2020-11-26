import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/ui/screens/reminder/widgets/list_item.dart';

import 'tag.dart';

class PasswordItem extends AbstractListItem {
  final PasswordModel data;
  static final ImageProvider<Object> defaultIcon =
      AssetImage("assets/icons/password-dict.png");

  PasswordItem(this.data);

  Widget _icon() {
    ImageProvider image =
        data.icon != null ? MemoryImage(data.icon) : defaultIcon;
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
      ),
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

  static final dateFormat = new DateFormat("yyyy-MM-dd");

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
      child: Row(
        children: [
          _icon(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _infoArea(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoArea(BuildContext context) {
    final String subtitle = data.account.isEmpty ? data.name : data.account;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        _remarkInfo(context),
      ],
    );
  }

  Widget _remarkInfo(BuildContext context) {
    final DateTime lastUpdated =
        DateTime.fromMillisecondsSinceEpoch(data.lastUpdatedTime);
    return Row(
      children: [
        Expanded(
          child: _tags(),
        ),
        Text(dateFormat.format(lastUpdated),
            style: Theme.of(context).textTheme.caption)
      ],
    );
  }

  @override
  void onClick(BuildContext context) {
    Navigator.of(context).pushNamed("/password/detail", arguments: data.id);
  }
}
