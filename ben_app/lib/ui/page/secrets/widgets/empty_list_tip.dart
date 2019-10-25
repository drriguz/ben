import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyListTipWidget extends StatelessWidget {
  final VoidCallback _onRefresh;

  const EmptyListTipWidget({Key key, VoidCallback onRefresh})
      : _onRefresh = onRefresh,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: 500,
        child: Center(
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
