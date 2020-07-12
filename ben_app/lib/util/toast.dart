import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static showError(String message, Error e) async {
    print(e);
    print(e.stackTrace);
    Fluttertoast.showToast(
        msg: message + " " + e.runtimeType.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
