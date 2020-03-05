import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';

import 'StudentScheduleDays.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class StudentSchedule extends StatefulWidget {
  final AppModelV2 model;

  StudentSchedule(this.model);

  @override
  State<StatefulWidget> createState() {
    return _StudentScheduleState();
  }
}

class _StudentScheduleState extends State<StudentSchedule> {
  int institutionId;
  int instructorId;
  var studentId;
  var dateNow;
  var startDate = 9999999999999;
  var endDate = 0000000000000;
  CalendarController _calendarController;
  List<Class> studentClass = new List();

  @override
  void initState() {
    institutionId = widget.model.currentInstitution.institutionId;
    studentId = widget.model.currentStudent.studentID;
    dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    print(DateTime.now());
    print(dateNow);

    widget.model.fetchStudentProgressByStudentID(studentId).then((value) {
      widget.model.studentProgresses.forEach((sp) async {
        await widget.model.findClassById(sp.classID).then((value) {
          studentClass.add(widget.model.searchClass);
        }).catchError((onError) {
          MessageDialog.show(context, 'Terjadi kesalahan $onError',
              'Coba ulangi lagi!', () => Navigator.of(context).pop());
        });
      });
    }).catchError((onError) {
      MessageDialog.show(context, 'Terjadi kesalahan $onError',
          'Coba ulangi lagi!', () => Navigator.of(context).pop());
    });

    widget.model
        .fetchTrainingClassByCompanyId(institutionId)
        .catchError((onError) {
      MessageDialog.show(context, 'Terjadi kesalahan $onError',
          'Coba ulangi lagi!', () => Navigator.of(context).pop());
    });

//    widget.model
//        .fetchClassByInstitutionIDAndInstructorID(institutionId, instructorId)
//        .then((onValue) {
//      setStartDateAndEndDate();
//      widget.model
//          .fetchTrainingClassByCompanyId(institutionId)
//          .catchError((onError) {
//        MessageDialog.show(context, 'Terjadi kesalahan $onError',
//            'Coba ulangi lagi!', () => Navigator.of(context).pop());
//      });
//    }).catchError((onError) {
//      MessageDialog.show(context, 'Terjadi kesalahan $onError',
//          'Coba ulangi lagi!', () => Navigator.of(context).pop());
//    });

    super.initState();

    _calendarController = CalendarController();
  }

  setStartDateAndEndDate() {
    studentClass.forEach((f) {
      if (f.startDateTime < startDate) {
        startDate = f.startDateTime;
      }

      if (f.endDateTime > endDate) {
        endDate = f.endDateTime;
      }
    });

    print('start date: ${DateTime.fromMillisecondsSinceEpoch(startDate)}');
    print('end date: ${DateTime.fromMillisecondsSinceEpoch(endDate)}');
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Jadwal Mengajar',
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');

    var dayName = DateFormat('EEEE').format(day);
    print(dayName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentScheduleDays(widget.model, day, studentClass),
      ),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  Widget _buildPageContent(AppModelV2 model) {
    setStartDateAndEndDate();
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: TableCalendar(
        startDay: DateTime.fromMillisecondsSinceEpoch(startDate),
        endDay: DateTime.fromMillisecondsSinceEpoch(endDate),
        calendarController: _calendarController,
        holidays: _holidays,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarStyle: CalendarStyle(
          selectedColor: Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown[700],
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
          formatButtonDecoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onDaySelected: _onDaySelected,
        onVisibleDaysChanged: _onVisibleDaysChanged,
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
