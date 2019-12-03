import 'package:bwa_learning/pages/admin/class_list/ClassList.dart';
import 'package:bwa_learning/pages/admin/studen_class/StudentClassList.dart';
import 'package:bwa_learning/pages/admin/student_list/StudentList.dart';
import 'package:bwa_learning/pages/admin/teacher_list/TeacherList.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'MyHomePage.dart';

void main() async => runApp(BWALearning());

class BWALearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BWALearningState();
  }
}

class _BWALearningState extends State<BWALearning> {
  AppModel _model;
  @override
  void initState() {
    _model = AppModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: MaterialApp(
        title: 'BWA Learning',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),

        routes: {
          '/': (BuildContext context) => MyHomePage(),
          '/classList': (BuildContext context) => ClassList(_model),
          '/teacherList': (BuildContext context) => TeacherList(),
          '/studentList': (BuildContext context) => StudentList(_model),
          '/studentClassList': (BuildContext context) => StudentClassList(_model),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage(),
          );
        },
      ),
    );
  }
}

