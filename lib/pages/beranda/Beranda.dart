
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/ui_elements/Akun.dart';
import 'package:bwa_learning/widgets/ui_elements/MenuUtama.dart';
import 'package:bwa_learning/widgets/ui_elements/ProgramBWA.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text('BWA Learning'),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String choice) {
            switch (choice) {
              case 'Settings':
                Navigator.pushNamed(context, '/settings');
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              )
            ];
          },
        ),
      ],
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      body: ListView(
        children: <Widget>[
          Akun(),
          Divider(),
          MenuUtama(),
          SizedBox(
            height: 50.0,
            width: 50.0,
          ),
          Divider(),
          ProgramBWA(),
        ],
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

        return stack;
      },
    );
  }
}


