import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/widgets/class/ClassListView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ClassList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClassListState();
  }
}

class _ClassListState extends State<ClassList> {
  List<Kelas> kelas = [];

  @override
  void initState() {
    setState(() {
      kelas = [
        Kelas(
          idKelas: '1',
          className: 'XA',
          level: 0,
          idInstitution: '001'
        ),
        Kelas(
          idKelas: '2',
          className: 'XB',
          level: 0,
            idInstitution: '001'
        ),
        Kelas(
          idKelas: '3',
          className: 'XC',
          level: 0,
          idInstitution: '001'
        ),
        Kelas(
          idKelas: '4',
          className: 'XD',
          level: 0,
          idInstitution: '002'
        ),
        Kelas(
          idKelas: '5',
          className: 'XE',
          level: 0,
          idInstitution: '002'
        ),
        Kelas(
          idKelas: '6',
          className: 'XF',
          level: 0,
          idInstitution: '002'
        ),
        Kelas(
            idKelas: '7',
          className: 'XI IPA 1',
          level: 1,
          idInstitution: '001'
        ),
        Kelas(
            idKelas: '8',
          className: 'XI IPS 2',
          level: 1,
            idInstitution: '001'
        ),
        Kelas(
            idKelas: '9',
          className: 'XII IPA 1',
          level: 2,
            idInstitution: '001'
        ),
        Kelas(
            idKelas: '10',
          className: 'XII IPS 1',
          level: 2,
            idInstitution: '001'
        ),
      ];
    });

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
      floatingActionButton: _buildFloatingActionButton(model),
      body: ClassListView(kelas),
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

