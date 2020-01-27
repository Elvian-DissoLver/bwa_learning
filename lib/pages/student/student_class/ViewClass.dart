import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/widgets/student/view_class/Feature.dart';
import 'package:bwa_learning/widgets/student/view_class/Header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {

        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Header(),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 70),
                ),
                Feature()
              ],
            ),
          ),
        );
      },
    );
  }
}