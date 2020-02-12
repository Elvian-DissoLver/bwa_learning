import 'package:bwa_learning/pages/student/student_class/ViewClass.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'MenuUtamaItem.dart';

class MenuUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModelV2>(
        builder: (BuildContext context, Widget child, AppModelV2 model) {
      return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: model.currentUser.status == 'admin'
              ? listAdminMainMenu(context, model)
              : model.currentUser.status == 'student'
                  ? listStudentMainMenu(context, model)
                  : model.currentUser.status == 'teacher'
                      ? listTeacherMainMenu(context, model)
                      : listStudentMainMenu(context, model));
    });
  }
}

List<MenuUtamaItem> listAdminMainMenu(BuildContext context, AppModelV2 model) {
  var menuUtamaItem = [
    MenuUtamaItem(
        title: 'Daftar Kelas',
        icon: Icons.class_,
        colorBox: Colors.blue,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/classList')),
    MenuUtamaItem(
        title: 'Daftar Guru',
        icon: (FontAwesomeIcons.chalkboardTeacher),
        colorBox: Colors.blue[900],
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherList')),
    MenuUtamaItem(
        title: 'Daftar Murid',
        icon: Icons.person_pin,
        colorBox: Colors.purple,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/studentList')),
    MenuUtamaItem(
        title: 'Daftar Pelajaran',
        icon: (FontAwesomeIcons.book),
        colorBox: Colors.redAccent,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/courseList')),
  ];

  return menuUtamaItem;
}

List<MenuUtamaItem> listStudentMainMenu(BuildContext context, AppModelV2 model) {
  var menuUtamaItem = [
    MenuUtamaItem(
        title: 'Jadwal Kelas',
        icon: (FontAwesomeIcons.chalkboard),
        colorBox: Colors.blue,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/studentScheduleList')),
    MenuUtamaItem(
        title: 'Kelasku',
        icon: Icons.class_,
        colorBox: Colors.blue[900],
        iconColor: Colors.white,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewClass(),
            ),
          );
        })
  ];

  return menuUtamaItem;
}

List<MenuUtamaItem> listTeacherMainMenu(BuildContext context, AppModelV2 model) {
  var menuUtamaItem = [
    MenuUtamaItem(
        title: 'Jadwal Mengajar',
        icon: (FontAwesomeIcons.chalkboard),
        colorBox: Colors.blue,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherSchedule')),
    MenuUtamaItem(
        title: 'Kelasku',
        icon: Icons.class_,
        colorBox: Colors.blue[900],
        iconColor: Colors.white,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewClass(),
            ),
          );
        }),
    MenuUtamaItem(
        title: 'Daftar   Pelajaran',
        icon: (FontAwesomeIcons.book),
        colorBox: Colors.redAccent,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherCourseList')),
    MenuUtamaItem(
        title: 'Update Progress Murid',
        icon: (FontAwesomeIcons.book),
        colorBox: Colors.lightGreenAccent,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherUpdateStudentProgress')),
    MenuUtamaItem(
        title: 'Update Mengajar',
        icon: (FontAwesomeIcons.book),
        colorBox: Colors.yellow,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherUpdateTopicLesson')),
    MenuUtamaItem(
        title: 'Daftar  Kehadiran',
        icon: (FontAwesomeIcons.clipboardCheck),
        colorBox: Colors.greenAccent,
        iconColor: Colors.white,
        onTap: () => Navigator.pushNamed(context, '/teacherAttendanceList'))
  ];

  return menuUtamaItem;
}
