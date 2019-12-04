import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class SuccessDialog {

  final String message;
  final Function onTap;

  SuccessDialog(this.message, this.onTap);

  Future show(
      BuildContext context) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        dialogType: DialogType.SUCCES,
        tittle: 'Success',
        desc: message,
        btnOkOnPress: onTap,
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }
}
