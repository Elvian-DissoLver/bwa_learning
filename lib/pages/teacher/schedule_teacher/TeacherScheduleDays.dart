import 'package:bwa_learning/models/talim/TimeSchedule.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

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
class TeacherScheduleDays extends StatefulWidget {
  final AppModelV2 model;
  DateTime day;

  TeacherScheduleDays(this.model, this.day);

  @override
  State<StatefulWidget> createState() {
    return _TeacherScheduleDaysState();
  }
}

class _TeacherScheduleDaysState extends State<TeacherScheduleDays> {
  int institutionId;
  int instructorId;
  int index = 0;
  DateTime date;
  String hari;
  String nowDay;
  List<TimeSchedule> schedules = new List();
  List<FlutterWeekViewEvent> events = new List();

  @override
  void initState() {
    date = DateTime(widget.day.year, widget.day.month, widget.day.day);

    institutionId = widget.model.currentInstitution.institutionId;
    instructorId = widget.model.currentInstructor.instructorId;

    nowDay = DateFormat('EEEE').format(widget.day);

    widget.model
        .fetchTimeScheduleByCompanyId(institutionId)
        .catchError((onError) {
      MessageDialog.show(
          context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
    }).whenComplete(() async {
      await widget.model
          .fetchScheduleByCompanyId(institutionId)
          .then((onValue) {
        print('done2');
      }).catchError((onError) {
        MessageDialog.show(
            context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
      });

      setUpSchedule(widget.model);
      events = event();

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
      hari = '';
      print(t.days);
      print(getDaysFromString(t.days));
      print(t.startTime);
      if (getDaysFromString(t.days) == nowDay) {
        if (t.startTime.toString() == '0:00:00.000000') {
          if (model.schedules.length > 0) {
            model.schedules.forEach((s) {
              index = 0;
              hari = '';
              print(s.days);
              print(getDaysFromString(s.days));
              if (getDaysFromString(s.days) == nowDay) {
                TimeSchedule timeSchedule = new TimeSchedule(
                    timeScheduleID: s.scheduleID,
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
      if (day[index] == '1' && nowDay == days[index]) {
        hari = days[index];
      }
      index++;
      getDaysFromString(day);
    }
    return hari;
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

  List<FlutterWeekViewEvent> event() {
    events = new List();

    schedules.sort((a, b) {
      return a.startTime.compareTo(b.startTime);
    });

    Duration duration;

    schedules.forEach((f) {
      print(f.name);

      duration = parseDuration(f.startTime.toString());
      print(duration.toString());

      FlutterWeekViewEvent flutterWeekViewEvent = new FlutterWeekViewEvent(
          title: f.name,
          description: 'Long',
          start: date.add(parseDuration(f.startTime.toString())),
          end: date.add(parseDuration(f.endTime.toString())),
          onTap: () {});
      events.add(flutterWeekViewEvent);
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
              currentTimeCircleColor: Colors.pink,
            )
          : Container(
              child:
                  Center(child: Text('Jadwal untuk hari ini belum tersedia')),
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
