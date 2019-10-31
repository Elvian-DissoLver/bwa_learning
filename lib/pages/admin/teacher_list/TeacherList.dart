import 'package:bwa_learning/models/Student.dart';
import 'package:bwa_learning/models/Teacher.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/student/StudentListView.dart';
import 'package:bwa_learning/widgets/teacher/TeacherListView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TeacherList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherListState();
  }
}

class _TeacherListState extends State<TeacherList> {
  List<Teacher> teacher = [];

  @override
  void initState() {
    setState(() {
      teacher = [
        Teacher(
            fullName: 'Sadewo',
            email: 'sadewo@mail.com',
            idKelas: '1'
        ),
        Teacher(
            fullName: 'Akel',
            email: 'akel@mail.com',
            idKelas: '2',
        ),
        Teacher(
            fullName: 'Yana',
            email: 'yana@mail.com',
            idKelas: '3',
        ),
      ];
    });

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Siswa',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _buildFloatingActionButton(model),
      body: TeacherListView(teacher),
    );
  }

  Widget _buildFloatingActionButton(AppModel model) {
    return FloatingActionButton(
      child: Icon(Icons.add),

      onPressed: () {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        return stack;
      },
    );
  }
}

