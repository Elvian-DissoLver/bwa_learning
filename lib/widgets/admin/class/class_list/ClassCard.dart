import 'package:bwa_learning/models/origin/Class.dart';
import 'package:bwa_learning/models/origin/LevelClass.dart';
import 'package:bwa_learning/pages/admin/class_list/AddNewClass.dart';
import 'package:bwa_learning/pages/admin/class_list/ViewClass.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ClassItem.dart';

// ignore: must_be_immutable
class ClassCard extends StatelessWidget {
  ClassCard(this.classData, this.level);

  final List<Class> classData;
  final level;

  List<Widget> listClass;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {

      listClass = listMyWidgets(context, model);

      return Container(
          margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                          'Kelas ${EnumToString.parse(SchoolHelper.getClassEnum(model.currentInstitution.level, level))}',
                          style: TextStyle(
                            fontFamily: 'ZillaSlab',
                            fontSize: 15,
                            color: Colors.black,
                          )),
                      Spacer(),
                      RaisedButton.icon(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddNewClass(this.level, model),
                                ),
                              ),
                          icon: Icon(Icons.add_circle),
                          label: Text('Tambah'),
                          color: Colors.green),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    height: 135,
                    child: listClass.length > 0 ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: classData.length > 0 ? 5 : 1,
                        children: listClass) : Center(
                      child: Text(
                        'Belum ada kelas. \r\nAyo tambahkan kelas.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  List<Widget> listMyWidgets(BuildContext context, AppModel model) {
    listClass = new List();

      classData.forEach((f) {
        if (level == f.level) {
          listClass.add(ClassItem(
            title: f.className,
            colorBox: Colors.tealAccent,
            onPressed: () {
              model.setCurrentClass(f);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewClass(),
                ),
              );
            },
          ));
        }
      });

    return listClass;
  }
}
