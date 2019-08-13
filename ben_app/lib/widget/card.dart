import 'package:flutter/material.dart';
import '../mode/bank_card.dart';

abstract class AbstractListItem<T> extends StatelessWidget {
  final T model;
  final bool hasDescription;

  const AbstractListItem({Key key, this.model, this.hasDescription})
      : super(key: key);

  Widget _buildIcon();

  Widget _buildTitle();

  Widget _buildDescription();

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      margin: const EdgeInsets.only(top: 5.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            _buildIcon(),
            Expanded(
              child: _buildTitle(),
              flex: 1,
            ),
            Expanded(
              child: _buildDescription(),
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              color: Colors.deepOrange,
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}

class CardListItem extends AbstractListItem<BankCard> {
  const CardListItem({Key key, BankCard model})
      : super(key: key, model: model, hasDescription: true);

  @override
  Widget _buildDescription() {
    return Text(
      '**** 8771',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget _buildIcon() {
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
  Widget _buildTitle() {
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

class CertificateListItem extends AbstractListItem<BankCard> {
  const CertificateListItem({Key key, BankCard model})
      : super(key: key, model: model, hasDescription: true);

  @override
  Widget _buildDescription() {
    return Text(
      '**** 8771',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget _buildIcon() {
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
  Widget _buildTitle() {
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
