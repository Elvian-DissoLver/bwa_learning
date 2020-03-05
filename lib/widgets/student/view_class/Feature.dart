import 'package:bwa_learning/pages/admin/schedule_class/page_task.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Feature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: EdgeInsets.all(16),
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/studentClassList'),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.tealAccent,
                                shape: BoxShape.circle
                            ),
                            child: RawMaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.person_pin,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text('Daftar Siswa', style: TextStyle(fontSize: 12.0, ), textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(model: model),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                shape: BoxShape.circle
                            ),
                            child: RawMaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.schedule,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text('Atur Jadwal Kelas', style: TextStyle(fontSize: 12.0, ), textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          );
        }
    );
  }
}
