import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/admin/class/class_list/ClassListView.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ClassList extends StatefulWidget {
  final AppModel model;

  ClassList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ClassListState();
  }
}

class _ClassListState extends State<ClassList> {

  @override
  void initState() {

    widget.model.fetchClassByInstitutionId(widget.model.currentInstitution.institutionId);

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Kelas',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: ClassListView(),
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

