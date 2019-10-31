import 'package:bwa_learning/models/Student.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/widgets/class/ClassListView.dart';
import 'package:bwa_learning/widgets/student/StudentListView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentListState();
  }
}

class _StudentListState extends State<StudentList> {
  List<Student> student = [];

  @override
  void initState() {
    setState(() {
      student = [
        Student(
          fullName: 'Iman',
          email: 'iman@mail.com',
          idKelas: '1',
          idInstitution: '001'
        ),
        Student(
          fullName: 'Tony',
          idKelas: '1',
            idInstitution: '001'
        ),
        Student(
          fullName: 'Ahmad',
          idKelas: '2',
            idInstitution: '002'
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
      body: StudentListView(student),
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

