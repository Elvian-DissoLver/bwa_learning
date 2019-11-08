import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bwa_learning/pages/admin/class_list/ClassList.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:flutter/material.dart';

class SuccessDialog {

  Future show(
      BuildContext context, AppModel model, String message) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        dialogType: DialogType.SUCCES,
        tittle: 'Succes',
        desc: message,
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassList(model),
            ),
          );
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }
}
