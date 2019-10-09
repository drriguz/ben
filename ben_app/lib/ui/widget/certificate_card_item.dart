import 'package:ben_app/ui/model/bank_card.dart';
import 'package:ben_app/ui/model/certificate_card.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class CertificateCardItem extends AbstractListItem<CertificateCard> {
  const CertificateCardItem({Key key, CertificateCard model})
      : super(key: key, model: model, hasDescription: true);

  @override
  Widget buildDescription() {
    return Text(
      '**** 8771',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget buildIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Image(
        image: AssetImage('assets/citic.png'),
        width: 32,
        height: 32,
      ),
    );
  }

  @override
  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
          color: Colors.orange,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text('储蓄卡',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
