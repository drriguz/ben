import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static showError(String message,
      {dynamic error, StackTrace? stackTrace}) async {
    String errorMsg =
        error == null ? message : message + " " + error.runtimeType.toString();
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget createCustomToast(
    String text, {
    Icon icon = const Icon(Icons.info_outline_rounded),
    Color backgroundColor = Colors.green,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );
  }
}
