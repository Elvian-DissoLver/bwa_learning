import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/widgets/kelas/kelasListView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DaftarKelas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DaftarKelasState();
  }
}

class _DaftarKelasState extends State<DaftarKelas> {
  List<Kelas> kelas = [];

  @override
  void initState() {
    setState(() {
      kelas = [
        Kelas(
          className: 'XA',
          level: 0,
        ),
        Kelas(
          className: 'XB',
          level: 0
        ),Kelas(
          className: 'XB',
          level: 0
        ),Kelas(
          className: 'XB',
          level: 0
        ),Kelas(
          className: 'XB',
          level: 0
        ),Kelas(
          className: 'XB',
          level: 0
        ),
        Kelas(
          className: 'XI IPA 1',
          level: 1
        ),
        Kelas(
          className: 'XII IPS 1',
          level: 2
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
      body: KelasListView(kelas),
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

