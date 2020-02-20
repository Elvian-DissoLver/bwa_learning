import 'package:bwa_learning/models/origin/Category.dart';
import 'package:bwa_learning/models/origin/Class.dart';
import 'package:bwa_learning/models/origin/Course.dart';
import 'package:bwa_learning/models/origin/ScheduleCourse.dart';
import 'package:bwa_learning/pages/teacher/schedule_teacher/ViewScheduleTeacher.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailScheduleTeacher extends StatefulWidget {
  final AppModel model;
  final String currentDay;

  DetailScheduleTeacher(
      {Key key, this.model, this.currentDay})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailScheduleTeacherState();
}

class _DetailScheduleTeacherState extends State<DetailScheduleTeacher> {
  TextEditingController itemController = new TextEditingController();
  Category category;
  Course selectCourse;
  ScheduleCourse scheduleCourse;
  Class selectClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Container(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: getExpenseItems(),

            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  getCategoryCourseName(int courseId) {

    int indexCourse = widget.model.courses.indexWhere((t) => t.courseId == courseId);

    int categoryId =  widget.model.courses.elementAt(indexCourse).categoryId;

    int indexCategory = widget.model.categories.indexWhere((t) => t.categoryId == categoryId);

    if(indexCourse != null) {
      category = Category(
          categoryId: categoryId,
          categoryName:  widget.model.categories.elementAt(indexCategory).categoryName
      );
      return category;
    }
  }

  getClassLessonName(int classId) {

    int indexClass = widget.model.classes.indexWhere((t) => t.classId == classId);

    if(indexClass != null) {
      selectClass = widget.model.classes.elementAt(indexClass);
      return selectClass;
    }
  }

  Widget getExpenseItems() {
    List<ScheduleCourse> currentScheduleCourses = new List();

    widget.model.scheduleCourses.forEach((f) {
      if (f.day == widget.currentDay) {
        print(f.startAt);
        currentScheduleCourses.add(f);
      }
    });

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        widget.currentDay,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: Text("Delete: " + widget.currentDay),
                              content: Text(
                                "Are you sure you want to reset this schedule?",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              actions: <Widget>[
                                ButtonTheme(
                                  //minWidth: double.infinity,
                                  child: RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                    color: Colors.deepPurpleAccent,
                                    textColor: const Color(0xffffffff),
                                  ),
                                ),
                                ButtonTheme(
                                  //minWidth: double.infinity,
                                  child: RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {},
                                    child: Text('YES'),
                                    color: Colors.deepPurpleAccent,
                                    textColor: const Color(0xffffffff),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 25.0,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 50.0),
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400.0,
                      color: Color(0xFFFCFCFC),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 350,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: currentScheduleCourses.length,
                            itemBuilder: (BuildContext context, int i) {
                              getClassLessonName(currentScheduleCourses.elementAt(i).classId);
                              return new Slidable(
                                delegate: new SlidableBehindDelegate(),
                                actionExtentRatio: 0.25,
                                child: GestureDetector(
                                  onTap: () {
                                    widget.model.setCurrentClass(getClassLessonName(currentScheduleCourses.elementAt(i).classId));
                                    widget.model.setCurrentCategory(getCategoryCourseName(currentScheduleCourses.elementAt(i).courseId));

                                    widget.model.courses.forEach((f) {
                                      if(f.courseId == currentScheduleCourses.elementAt(i).courseId) {
                                        setState(() {
                                          selectCourse = f;
                                          widget.model.setCurrentCourse(selectCourse);
                                        });
                                      }
                                    });

                                    widget.model.setCurrentScheduleCourse(currentScheduleCourses.elementAt(i));

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewScheduleTeacher(model: widget.model),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.green ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 30.0),
                                          ),
                                          Flexible(
                                              child: Text(
                                                selectClass.className,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                ),
                                              )
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 30.0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              currentScheduleCourses
                                                  .elementAt(i)
                                                  .startAt.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
