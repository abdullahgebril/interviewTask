

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showFlutterToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue[600],
      textColor: Colors.white,
      fontSize: 18.0);
}
