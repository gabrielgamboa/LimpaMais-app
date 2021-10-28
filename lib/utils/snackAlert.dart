import 'package:flutter/material.dart';

snackAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: "Ok",
      onPressed: () {
        print("ok");
      },
    ),
  ));
}
