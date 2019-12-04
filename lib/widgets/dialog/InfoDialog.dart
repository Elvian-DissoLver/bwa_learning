import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class InfoDialog {

  final String message;
  final Function onOKTap;

  InfoDialog(this.message, this.onOKTap);

  Future show(
      BuildContext context) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.INFO,
        tittle: 'Info',
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress: onOKTap,
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }
}
