import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewStudentSchedule extends StatefulWidget {
  final AppModelV2 model;

  ViewStudentSchedule(
      {Key key, this.model})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewStudentScheduleState();
}

class _ViewStudentScheduleState extends State<ViewStudentSchedule> {
  DateTime _date = new DateTime.now();

  onDateChanged(DateTime date) {
    _date = date;
    //setState(() {}); //optional
  }

  @override
  void initState() {
    super.initState();

    widget.model
        .fetchInstructorById(widget.model.currentClass.instructorId)
        .catchError((onError) {
      MessageDialog.show(context, 'Terjadi kesalahan $onError',
          'Coba ulangi lagi!', () => Navigator.of(context).pop());
      setState(() {
        widget.model.setLoading(false);
      });
    });
  }

  updateCourseClass(AppModel model) {}

  alertUpdateCourse(AppModel model) {
    var alert = new AlertDialog(
      title: Text("Set Reminder"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Date
          SelectDateButton(
            date: _date,
            dateCallback: onDateChanged,
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => debugPrint("Save button"), child: Text('Save')),
        new FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel'))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModelV2>(
      builder: (BuildContext context, Widget child, AppModelV2 model) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 50),
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
                      model.currentClass.classNo,
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
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      widget.model.currentTrainingClass.name,
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
                                  "https://source.unsplash.com/ZHvM3XIOHoE" ??
                                      Icons.person_pin)),
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
                            model.currentInstructor.name,
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
//                Container(
//                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                  padding: EdgeInsets.all(10),
//                  width: MediaQuery.of(context).size.width - 32,
//                  height: 120,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(8),
//                    boxShadow: [
//                      BoxShadow(
//                        blurRadius: 4,
//                        spreadRadius: 2,
//                        color: Colors.black.withOpacity(0.3),
//                      ),
//                    ],
//                  ),
//                  child: Column(
////                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Text(
//                                'Mata Pelajaran',
//                                style: TextStyle(
//                                  color: Color(0xff7a7a7a),
//                                  fontFamily: 'Medium',
//                                  fontSize: 12,
//                                ),
//                              ),
//                              Spacer(),
//                              Text(
//                                model.currentCourseState.isDone == 1
//                                    ? 'Sudah Dipelajari'
//                                    : 'Sedang Dipelajari',
//                                style: TextStyle(
//                                  color: Color(0xff7a7a7a),
//                                  fontFamily: 'Medium',
//                                  fontSize: 12,
//                                ),
//                              ),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                iconSize: 20,
//                                onPressed: () => alertUpdateCourse(model),
//                              )
//                            ],
//                          ),
//                          SizedBox(
//                            height: 5,
//                          ),
//                          Text(
//                            model.currentCourse.courseName.toString(),
//                            style: TextStyle(
//                              color: Colors.black,
//                              fontFamily: 'Medium',
//                              fontSize: 16,
//                            ),
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
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
                                shape: BoxShape.circle),
                            child: RawMaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              child:
                                  Icon(Icons.access_alarm, color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${model.currentTimeSchedule.startTime} - ${model.currentTimeSchedule.endTime}',
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

class SelectDateButton extends StatefulWidget {
  final DateTime date;

  final ValueChanged<DateTime> dateCallback;

  SelectDateButton({Key key, this.date, this.dateCallback}) : super(key: key);

  @override
  SelectDateButtonState createState() {
    return new SelectDateButtonState();
  }
}

class SelectDateButtonState extends State<SelectDateButton> {
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = widget.date;
  }

  void selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2019),
    );
    if (picked != null) {
      widget.dateCallback(picked);
      _date = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      onChanged: (value) {},
//      value: selectLevelClass,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      hint: Text(
        "Pilih tingkat pelajaran!",
      ),
      items: ['Kelas X', 'Kelas XI', 'Kelas XII'].map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
    );
  }
}
