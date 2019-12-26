import 'package:bwa_learning/models/User.dart';
import 'package:bwa_learning/pages/admin/class_list/ClassList.dart';
import 'package:bwa_learning/pages/admin/course_list/CourseList.dart';
import 'package:bwa_learning/pages/admin/student_class/StudentClassList.dart';
import 'package:bwa_learning/pages/admin/student_list/StudentList.dart';
import 'package:bwa_learning/pages/admin/teacher_list/TeacherList.dart';
import 'package:bwa_learning/pages/student/schedule_class/SchedulePage.dart';
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
  User user;
  @override
  void initState() {
    _model = AppModel();

    _model.fetchInstitutionById(1234);

    _model.findUserByEmail("iman@mail.com").then((onValue) {
      _model.currentUser.status == 'student' && _model.currentInstitution != null ? _model.fetchStudentByEmail(_model.currentUser.email, _model.currentInstitution.institutionId).then((onValue) {
        _model.findStudentClassById(_model.currentStudent.classId);
      }) :
        null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BWA Learning',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),

        routes: {
          '/': (BuildContext context) => MyHomePage(),
          // admin
          '/classList': (BuildContext context) => ClassList(_model),
          '/teacherList': (BuildContext context) => TeacherList(model: _model),
          '/studentList': (BuildContext context) => StudentList(_model),
          '/studentClassList': (BuildContext context) => StudentClassList(_model),
          '/courseList': (BuildContext context) => CourseList(_model),
          // student
          '/scheduleList': (BuildContext context) => SchedulePage(model: _model),
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

