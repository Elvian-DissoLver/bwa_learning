import 'package:flutter/material.dart';

class MessageDialog {
  static void show(
      BuildContext context, String title, String message, final Function onPressed
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: onPressed,
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }
}
