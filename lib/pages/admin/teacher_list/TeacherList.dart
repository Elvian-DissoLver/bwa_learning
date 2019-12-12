import 'package:bwa_learning/models/Teacher.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/admin/teacher/TeacherListView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TeacherList extends StatefulWidget {

  final AppModel model;

  const TeacherList({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TeacherListState();
  }
}

class _TeacherListState extends State<TeacherList> {

  @override
  void initState() {

    widget.model.fetchTeacherByIdInstitution(1234);

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Guru',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _buildFloatingActionButton(model),
      body: TeacherListView(),
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

