// show snackbar with a message
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    // close all other snackbars
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 1)),
    );
  }
}
