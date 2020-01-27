import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class ViewScheduleCourse extends StatefulWidget {
  final AppModel model;

  ViewScheduleCourse(
      {Key key, this.model})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewScheduleCourseState();
}

class _ViewScheduleCourseState extends State< ViewScheduleCourse> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchTeacherById(widget.model.currentCourse.teacherId);
    widget.model.fetchCourseStateByCourseIdAndClassId(widget.model.currentScheduleCourse.courseId, widget.model.currentScheduleCourse.classId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {

        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 70),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.all(10),
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      model.currentCategory.categoryName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Medium',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 32,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff4ede7b),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Guru Pengajar',
                            style: TextStyle(
                              color: Color(0xff7a7a7a),
                              fontFamily: 'Medium',
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            model.currentTeacher.fullName,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Medium',
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 32,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Mata Pelajaran',
                                style: TextStyle(
                                  color: Color(0xff7a7a7a),
                                  fontFamily: 'Medium',
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Text(
                                model.currentCourseState.isDone == 1 ? 'Sudah Dipelajari' : 'Sedang Dipelajari',
                                style: TextStyle(
                                  color: Color(0xff7a7a7a),
                                  fontFamily: 'Medium',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            model.currentCourse.courseName.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Medium',
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 32,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Jam Belajar',
                            style: TextStyle(
                              color: Color(0xff7a7a7a),
                              fontFamily: 'Medium',
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
//                              Text(
//                                model.currentCourseState.isDone == 1 ? 'Sudah Dipelajari' : 'Sedang Dipelajari',
//                                style: TextStyle(
//                                  color: Color(0xff7a7a7a),
//                                  fontFamily: 'Medium',
//                                  fontSize: 12,
//                                ),
//                              ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle
                            ),
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              child: Icon(Icons.access_alarm, color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${model.currentScheduleCourse.startAt} - ${model.currentScheduleCourse.endAt}',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Medium',
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

