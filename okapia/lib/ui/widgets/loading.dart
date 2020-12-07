import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                S.of(context).loading,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
