import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/undraw_to_the_moon_v1mv.png"),
          Text(S.of(context).description_start_usage),
          TextButton(onPressed: () {}, child: Text(S.of(context).button_start))
        ],
      ),
    );
  }
}
