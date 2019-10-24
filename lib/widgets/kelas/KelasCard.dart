import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/kelas/KelasItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.indigo,
  Colors.red,
  Colors.cyan,
  Colors.teal,
  Colors.amber.shade900,
  Colors.deepOrange
];

class KelasCard extends StatelessWidget {

  KelasCard(
      this.kelasData,
      this.level,
      this.tingkat
  );

  final List<Kelas> kelasData;
  final level;
  final tingkat;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          Color color = colorList.elementAt(
              level % colorList.length);

          return Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [buildBoxShadow(color, context)],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {

                  },
                  splashColor: color.withAlpha(20),
                  highlightColor: color.withAlpha(10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tingkat == 'sma' && level == 0 ? 'Kelas X' :
                          tingkat == 'sma' && level == 1 ? 'Kelas XI' :
                          'Kelas XII',
                          style: TextStyle(
                              fontFamily: 'ZillaSlab',
                              fontSize: 15,
                              color: Colors.black
                          )
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 14),
                          alignment: Alignment.centerRight,

                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 5,
                            children: ListMyWidgets()
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        }
    );
  }

  List<Widget> ListMyWidgets() {

    List<Widget> list = new List();

    kelasData.forEach((f) {
      if (level == f.level) {
        list.add(
            KelasItem(
              title: f.className,
              colorBox: Colors.tealAccent,
              onPressed: () { print(f.className +" was tapped"); },
            )
        );
      }
    });
    return list;
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return BoxShadow(
          blurRadius: 8,
          offset: Offset(0, 8));
    }
    return BoxShadow(
        blurRadius: 8,
        offset: Offset(0, 8));
  }
}

