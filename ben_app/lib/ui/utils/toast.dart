import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static showError(String message,
      {dynamic error, StackTrace stackTrace}) async {
    String errorMsg =
        error == null ? message : message + " " + error.runtimeType.toString();
    if (stackTrace != null) print(stackTrace);
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
