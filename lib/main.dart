import 'package:bwa_learning/pages/admin/class_list/ClassList.dart';
import 'package:bwa_learning/pages/admin/course_list/CourseList.dart';
import 'package:bwa_learning/pages/admin/student_class/StudentClassList.dart';
import 'package:bwa_learning/pages/admin/student_list/StudentList.dart';
import 'package:bwa_learning/pages/admin/teacher_list/TeacherList.dart';
import 'package:bwa_learning/pages/student/schedule_class/SchedulePage.dart';
import 'package:bwa_learning/pages/teacher/attendance_list/TeacherAttendanceList.dart';
import 'package:bwa_learning/pages/teacher/course_list/TeacherCourseList.dart';
import 'package:bwa_learning/pages/teacher/schedule_teacher/ScheduleTeacher.dart';
import 'package:bwa_learning/pages/teacher/update_topic_lesson/TeacherUpdateTopicLesson.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'MyHomePage.dart';
import 'models/talim/User.dart';

void main() async => runApp(BWALearning());

class BWALearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BWALearningState();
  }
}

class _BWALearningState extends State<BWALearning> {
  AppModel _model;
  AppModelV2 _model2;
  User user;
  @override
  void initState() {
    _model = AppModel();
    _model2 = AppModelV2();

    _model.fetchInstitutionById(1234);
    _model2.fetchInstitutionById(1234);

//    _model.findUserByEmail("iman@mail.com").then((onValue) {
    _model2.findUserByEmail("ewo@mail.com").then((onValue) {
      _model2.currentUser.status == 'student' &&
              _model2.currentInstitution != null
          ? _model
              .fetchStudentByEmail(_model.currentUser.email,
                  _model.currentInstitution.institutionId)
              .then((onValue) {
              _model.findStudentClassById(_model.currentStudent.classId);
            })
          : _model2.currentUser.status == 'teacher' &&
                  _model2.currentInstitution != null
              ? _model2
                  .fetchInstructorByEmail(_model2.currentUser.email)
              : null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModelV2>(
      model: _model2,
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
          '/studentClassList': (BuildContext context) =>
              StudentClassList(_model),
          '/courseList': (BuildContext context) => CourseList(_model),
          // student
          '/studentScheduleList': (BuildContext context) =>
              SchedulePage(model: _model),
          // teacher
          '/teacherScheduleList': (BuildContext context) =>
              ScheduleTeacher(model: _model),
          '/teacherCourseList': (BuildContext context) =>
              TeacherCourseList(_model),
          '/teacherCourseList': (BuildContext context) =>
              TeacherUpdateTopicLesson(_model2),
          '/teacherAttendanceList': (BuildContext context) =>
              TeacherAttendanceList(_model2),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(),
          );
        },
      ),
    );
  }
}
