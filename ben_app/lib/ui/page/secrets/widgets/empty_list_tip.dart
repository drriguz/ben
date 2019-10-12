import 'package:flutter/cupertino.dart';

class EmptyListTipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          width: 150,
          image: AssetImage('assets/undraw_not_found_60pq.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text("暂无数据"),
        ),
      ],
    );
  }
}
