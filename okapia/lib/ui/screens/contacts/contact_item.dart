import 'package:flutter/material.dart';
import 'package:okapia/common/sqlite/entity/contact_entity.dart';

class ContactItem extends StatelessWidget {
  final ContactEntity data;

  const ContactItem(this.data, {Key key}) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "张三",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              "6a:de:e0:af:56:f8:0c:04:11:5b:ef:4d:49:ad:09:23",
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ));
  }

  void onClick(BuildContext context) async {
    Navigator.of(context).pushNamed("/chat", arguments: data.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(context),
      child: Card(
        borderOnForeground: false,
        margin: const EdgeInsets.only(top: 5.0),
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 70.0,
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }
}
