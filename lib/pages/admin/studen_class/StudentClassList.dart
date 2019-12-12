import 'package:bwa_learning/pages/admin/studen_class/AddNewStudentClass.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/admin/student/StudentListView.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StudentClassList extends StatefulWidget {

  final AppModel model;

  StudentClassList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _StudentClassListState();
  }
}

class _StudentClassListState extends State<StudentClassList> {

  @override
  void initState() {
    widget.model.fetchStudentByIdClass(widget.model.currentClass.idClass);

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
      body: StudentListView(),
    );
  }

  Widget _buildFloatingActionButton(AppModel model) {
    return FloatingActionButton(
      child: Icon(Icons.add),

      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>AddNewStudentClass(model),
        ),
      ),
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

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}

