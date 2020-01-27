import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/widgets/admin/course/CourseListView.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CourseList extends StatefulWidget {

  final AppModel model;

  CourseList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _CourseListState();
  }
}

class _CourseListState extends State<CourseList> {

  @override
  void initState() {

    widget.model.fetchCourseByInstitutionId(1234);

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Pelajaran',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      body: CourseListView(),
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

