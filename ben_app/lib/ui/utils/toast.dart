import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static showError(String message, dynamic e) async {
    print(e);
    String errorMsg = e == null ? message : message + " " + e.runtimeType.toString();
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
