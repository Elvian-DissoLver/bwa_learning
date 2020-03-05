import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/TimeSchedule.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ViewStudentSchedule.dart';

List<String> days = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

// ignore: must_be_immutable
class StudentScheduleDays extends StatefulWidget {
  final AppModelV2 model;
  DateTime day;
  List<Class> studentClass;

  StudentScheduleDays(this.model, this.day, this.studentClass);

  @override
  State<StatefulWidget> createState() {
    return _StudentScheduleDaysState();
  }
}

class _StudentScheduleDaysState extends State<StudentScheduleDays> {
  int institutionId;
  int instructorId;
  int index = 0;
  DateTime date;
  String findDay;
  String selectedDay;
  List<TimeSchedule> schedules = new List();
  List<FlutterWeekViewEvent> events = new List();

  @override
  void initState() {
    date = DateTime(widget.day.year, widget.day.month, widget.day.day);

    institutionId = widget.model.currentInstitution.institutionId;
//    instructorId = widget.model.currentInstructor.instructorId;

    selectedDay = DateFormat('EEEE').format(widget.day);

    widget.model
        .fetchTimeScheduleByCompanyId(institutionId)
        .then((onValue) async {
      await widget.model
          .fetchScheduleByCompanyId(institutionId)
          .catchError((onError) {
        MessageDialog.show(
          context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!', () => Navigator.of(context).pop());
        setState(() {
          widget.model.setLoading(false);
        });
      });

    }).catchError((onError) {
      MessageDialog.show(
          context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!', () => Navigator.of(context).pop());
      setState(() {
        widget.model.setLoading(false);
      });
    }).whenComplete((){
      setUpSchedule(widget.model);
      events = event(widget.model);

      events.forEach((f) {
        print('print ${f.title}');
      });
    });

    super.initState();

    print('dateSelect: $date');
  }

  setUpSchedule(AppModelV2 model) {
    schedules = [];
    model.timeSchedules.forEach((t) {
      index = 0;
      findDay = '';
      print(t.days);
      print(getDaysFromString(t.days));
      print(t.startTime);
      if (getDaysFromString(t.days) == selectedDay) {
        if (t.startTime.toString() == '0:00:00.000000') {
          if (model.schedules.length > 0) {
            model.schedules.forEach((s) {
              index = 0;
              findDay = '';
              print(s.days);
              print(getDaysFromString(s.days));
              if (getDaysFromString(s.days) == selectedDay) {
                TimeSchedule timeSchedule = new TimeSchedule(
                    timeScheduleID: s.timeScheduleID,
                    scheduleID: s.scheduleID,
                    name: s.name,
                    startDate: s.startDate,
                    endDate: s.endDate,
                    startTime: s.startTime,
                    endTime: s.endTime,
                    days: s.days,
                    companyID: s.companyID,
                    months: '1',
                    weeks: '1');
                schedules.add(timeSchedule);
              }
            });
          }
        } else {
          schedules.add(t);
        }
      }
    });

    print('objectSchedulesFix');
    schedules.forEach((f) {
      print('ScheduleFix: ${f.timeScheduleID}');
    });
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Jadwal Mengajar',
      ),
    );
  }

  String getDaysFromString(String day) {
    if (index < 7) {
      if (day[index] == '1' && selectedDay == days[index]) {
        findDay = days[index];
      }
      index++;
      getDaysFromString(day);
    }
    return findDay;
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  List<FlutterWeekViewEvent> event(AppModelV2 model) {
    events = new List();

    schedules.sort((a, b) {
      return a.startTime.compareTo(b.startTime);
    });

    Duration duration;

    schedules.forEach((s) {
      print(s.timeScheduleID);
      model.setCurrentTimeSchedule(s);
      int indexClass = widget.studentClass.indexWhere((t) => t.timeScheduleID == s.timeScheduleID);
      if (indexClass > -1) {
        model.setCurrentClass(widget.studentClass.elementAt(indexClass));
        int indexTC = model.trainingClasses.indexWhere((t) =>
        t.trainingClassID == model.currentClass.trainingClassID);
        model.setCurrentTrainingClass(model.trainingClasses.elementAt(
            indexTC));

        duration = parseDuration(s.startTime.toString());
        print(duration.toString());

        FlutterWeekViewEvent flutterWeekViewEvent = new FlutterWeekViewEvent(
            title: model.currentClass.classNo,
            description: model.currentTrainingClass.name,
            start: date.add(parseDuration(s.startTime.toString())),
            end: date.add(parseDuration(s.endTime.toString())),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewStudentSchedule(
                        model: model
                      ),
                ),
              );
            });
        events.add(flutterWeekViewEvent);
      }
    });

    return events;
  }

  Widget _buildPageContent(AppModelV2 model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: events.length > 0
          ? DayView(
              date: widget.day,
              events: events,
              currentTimeCircleColor: Colors.purple,
            )
          : Container(
              child:
                  Center(child: Text('Jadwal untuk ${DateFormat('yyyy-MM-dd').format(widget.day)} belum tersedia')),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModelV2>(
      builder: (BuildContext context, Widget child, AppModelV2 model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}
