import 'package:bwa_learning/models/origin/LevelClass.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ClassCard.dart';

class ClassListView extends StatelessWidget {

  Widget _buildEmptyText(AppModel model) {
    String emptyText;

    emptyText = 'Belum ada kelas. \r\nAyo coba buat kelas.';

//    Widget svg = new SvgPicture.asset(
//      'assets/img/todo_list.svg',
//      width: 200,
//    );

    return Container(
      color: Color.fromARGB(16, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          svg,
          SizedBox(
            height: 40.0,
          ),
          Text(
            emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.lightBlue
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(AppModel model) {
    return ListView.builder(
      itemCount: SchoolHelper.getIteration(model.currentInstitution.level),
      itemBuilder: (BuildContext context, int index) {
         return ClassCard(model.classes, index);
  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Widget classCards = _buildListView(model);

        return classCards;
      },
    );
  }
}