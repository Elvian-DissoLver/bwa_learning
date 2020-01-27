import 'package:bwa_learning/models/origin/ScheduleCourse.dart';
import 'package:bwa_learning/pages/teacher/schedule_teacher/DetailScheduleTeacher.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

List<String> day = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  "Jum'at",
  'Sabtu',
  'Minggu'
];

class ScheduleTeacher extends StatefulWidget {
  final AppModel model;

  ScheduleTeacher({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleTeacherState();
}

class _ScheduleTeacherState extends State<ScheduleTeacher>
    with SingleTickerProviderStateMixin {
  int index = 1;

  @override
  void initState() {
    super.initState();

    widget.model
        .fetchScheduleCourseByTeacherId(widget.model.currentTeacher.teacherId);

    widget.model.fetchCourseByInstitutionId(1234);

    widget.model.fetchClassByInstitutionId(widget.model.currentInstitution.institutionId);

    widget.model.fetchCategory();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
      return Scaffold(
        body: ListView(
          children: <Widget>[
            _getToolbar(context),
            new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Jadwal ',
                                style: new TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Ku',
                                style: new TextStyle(
                                    fontSize: 28.0, color: Colors.grey),
                              )
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Container(
                height: 360.0,
                padding: EdgeInsets.only(bottom: 25.0),
                child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowGlow();
                    },
                    child: model.scheduleCourses.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ))
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                            scrollDirection: Axis.horizontal,
                            children: getExpenseItems(model),
                          )),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getCategoryCourseName(int courseId) {
    String categoryCourseName;

    int indexCourse = widget.model.courses.indexWhere((t) => t.courseId == courseId);

    int categoryId =  widget.model.courses.elementAt(indexCourse).categoryId;

    int indexCategory = widget.model.Categories.indexWhere((t) => t.categoryId == categoryId);

//    indexCourse != null ? categoryCourseName = widget.model.courses.elementAt(indexCourse).courseName : categoryCourseName = '';
    indexCourse != null ? categoryCourseName = widget.model.Categories.elementAt(indexCategory).categoryName : categoryCourseName = '';

    return Text(
      categoryCourseName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.0,
      ),
    );
  }

  Widget getClassLessonName(int classId) {
    String classLessonName;

    int indexClass = widget.model.classes.indexWhere((t) => t.classId == classId);

    indexClass != null ? classLessonName = widget.model.classes.elementAt(indexClass).className : classLessonName = '';

    return Text(
      classLessonName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.0,
      ),
    );
  }

  getExpenseItems(AppModel model) {

    return new List.generate(day.length, (int index) {

      List<ScheduleCourse> schedulePerDay = new List();

      model.scheduleCourses.forEach((f) {
        if (f.day == day.elementAt(index)) {
          schedulePerDay.add(f);
        }
      });

      return new GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailScheduleTeacher(
                model: widget.model,
                currentDay: day.elementAt(index),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      new ScaleTransition(
                scale: new Tween<double>(
                  begin: 1.5,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.50,
                      1.00,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(
                        0.00,
                        0.50,
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          color: Colors.deepPurpleAccent,
          child: new Container(
            width: 180.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                    child: Container(
                      child: Text(
                        day.elementAt(index),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                        ),
                      ),
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
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: schedulePerDay.length,
                              itemBuilder: (BuildContext ctxt, int i) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: getClassLessonName(schedulePerDay.elementAt(i).classId)
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 30.0),
                                    ),
//                                    Flexible(
//                                      child: Text(
//                                        schedulePerDay
//                                            .elementAt(i)
//                                            .startAt.toString(),
//                                        overflow: TextOverflow.ellipsis,
//                                        maxLines: 1,
//                                        style: TextStyle(
//                                          color: Colors.black,
//                                          fontSize: 17.0,
//                                        ),
//                                      ),
//                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/img/list.png')),
      ]),
    );
  }
}
