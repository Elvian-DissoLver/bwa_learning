import 'package:bwa_learning/models/Kelas.dart';
import 'package:flutter/material.dart';

import 'KelasCard.dart';


class KelasListView extends StatelessWidget {
  final List<Kelas> kelas;

  KelasListView(this.kelas);

  @override
  Widget build(BuildContext context) {
    Widget kelasCards;

    if (kelas.length > 0) {
      kelasCards = ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return KelasCard(kelas, index, 'sma');
        },
      );
    } else {
      kelasCards = Center(
        child: Text('There are no todo yet. Please create one.'),
      );
    }

    return kelasCards;
  }
}