import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/states/InitializationState.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/undraw_to_the_moon_v1mv.png"),
          Text(S.of(context).description_start_usage),
          Consumer<InitializationState>(
            builder: (_, state, child) {
              return TextButton(
                onPressed: state.initializeApplication,
                child: Text(S.of(context).button_start),
              );
            },
          ),
          Consumer<InitializationState>(
            builder: (_, state, child) {
              if (state.isBusy) {
                return const CircularProgressIndicator();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
