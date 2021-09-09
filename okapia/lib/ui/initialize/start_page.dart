import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/states/initialization_state.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/undraw_to_the_moon_v1mv.png"),
          Text(S.of(context).description_start_usage),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Consumer<InitializationState>(
              builder: (_, state, child) {
                if (state.isBusy) {
                  return const CircularProgressIndicator();
                } else {
                  return TextButton(
                    onPressed: () => _OnInitialize(state, context),
                    child: Text(S.of(context).button_start),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _OnInitialize(
      InitializationState state, BuildContext context) async {
    await state.initializeApplication();
    await Navigator.pushReplacementNamed(context, "/home");
  }
}
