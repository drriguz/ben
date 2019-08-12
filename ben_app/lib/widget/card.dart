import 'package:flutter/material.dart';
import '../mode/bank_card.dart';

class CardListItem extends StatelessWidget {
  const CardListItem(this.card);

  final BankCard card;

  Widget _createIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Image(
        image: AssetImage('assets/citic.png'),
        width: 32,
        height: 32,
      ),
    );
  }

  Widget _createTitle() {
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
            card.title,
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

  Widget _createNumber() {
    return Text(
      '**** 8771',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            _createIcon(),
            Expanded(
              child: _createTitle(),
              flex: 1,
            ),
            Expanded(
              child: _createNumber(),
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
