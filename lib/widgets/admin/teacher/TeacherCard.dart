import 'package:bwa_learning/models/origin/Teacher.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
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

class TeacherCard extends StatelessWidget {

  TeacherCard(this.teacherData);

  final Teacher teacherData;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {

          Color color = colorList.elementAt(
              teacherData.fullName.length % colorList.length);
          return Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
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
                      child: Row(
                        children:[
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://source.unsplash.com/ZHvM3XIOHoE" ?? Icons.person_pin
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '${teacherData.fullName
                                      .trim()
                                      .length <= 20 ? teacherData.fullName.trim() : teacherData
                                      .fullName.trim().substring(0, 20) + '...'}',
                                  style: TextStyle(
                                      fontFamily: 'ZillaSlab',
                                      fontSize: 20,
                                      color: Colors.black
                                  )
                              ),

                              Container(
                                  margin: EdgeInsets.only(top: 14),
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '${teacherData.email.toString()
                                            .trim()
                                            .split('\n')
                                            .first
                                            .length <= 30 ? teacherData.email.toString()
                                            .trim()
                                            .split('\n')
                                            .first : teacherData.email.toString()
                                            .trim()
                                            .split('\n')
                                            .first
                                            .substring(0, 30) + '...'}',
                                        style:
                                        TextStyle(fontSize: 14, color: Colors.black54),
                                      ),

                                    ],
                                  )


                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ));
        }
    );
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

