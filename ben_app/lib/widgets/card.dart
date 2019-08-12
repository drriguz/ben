import 'package:flutter/material.dart';
import '../modes/bank_card.dart';

class CardListItem extends StatelessWidget {
  const CardListItem(this.card);

  final BankCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage('assets/citic.png'),
              width: 32,
              height: 32,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(card.title),
                  Text('储蓄卡'),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(5.0),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
