import 'package:bwa_learning/scoped_models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:bwa_learning/pages/pesanan.dart';
import 'package:scoped_model/scoped_model.dart';

import 'MyHomePage.dart';

void main() async => runApp(BWALearning());

class BWALearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BWALearningState();
  }
}

class _BWALearningState extends State<BWALearning> {
  AppModel _model;
  @override
  void initState() {
    _model = AppModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: MaterialApp(
        title: 'Note.Ku',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),

        routes: {
          '/': (BuildContext context) => MyHomePage(),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage(),
          );
        },
      ),
    );
  }
}

