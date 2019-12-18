import 'package:bwa_learning/models/ScheduleCourse.dart';
import 'package:bwa_learning/pages/admin/schedule_class/page_detail.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'page_addlist.dart';

List<String> day = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  "Jum'at",
  'Sabtu',
  'Minggu'
];

class TaskPage extends StatefulWidget {
  final AppModel model;

  TaskPage({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  int index = 1;

  @override
  void initState() {
    super.initState();

    widget.model
        .fetchScheduleCourseByclassId(widget.model.currentClass.classId);

    widget.model.fetchCourseByInstitutionId(1234);

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
                                model.currentClass.className,
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

  Widget getCourseName(int courseId) {
    String courseName;

    int index = widget.model.courses.indexWhere((t) => t.courseId == courseId);

    index != null ? courseName = widget.model.courses.elementAt(index).courseName : courseName = '';

    return Text(
      courseName,
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
              pageBuilder: (_, __, ___) => new DetailPage(
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
                                      child: getCourseName(schedulePerDay.elementAt(i).courseId)
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 30.0),
                                    ),
                                    Flexible(
                                      child: Text(
                                        schedulePerDay
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

  void _addTaskPressed() async {
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new NewTaskPage(
          user: widget.model.currentUser,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
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
    //Navigator.of(context).pushNamed('/new');
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
