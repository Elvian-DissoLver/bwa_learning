import 'package:bwa_learning/models/origin/Course.dart';
import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/Session.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:bwa_learning/widgets/teacher/course_list/CourseCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tree_view/tree_view.dart';

class TeacherAttendanceList extends StatefulWidget {
  final AppModelV2 model;

  TeacherAttendanceList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _TeacherAttendanceListState();
  }
}

class _TeacherAttendanceListState extends State<TeacherAttendanceList> {
  Class selectLevelClass;
  Session selectSessions;
  bool showSessions = false;
  List<Course> listCourses;

  @override
  void initState() {
    widget.model.fetchClassByInstitutionId(widget.model.currentInstitution.institutionId);

    super.initState();
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Daftar Kehadiran',
      ),
    );
  }

  Widget _buildDropDownClassLevel(AppModelV2 model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.all(10),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: DropdownButton<Class>(
          value: selectLevelClass,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              selectLevelClass = newValue;
            });
            model.fetchSessionByClassId(newValue.classId).then((onValue) {
              if(onValue){
                setState(() {
                  showSessions = true;
                });
              } else {
                return MessageDialog.show(
                    context, 'Tidak ditemukan', 'Belum tersedia Sesi untuk kelas ${selectLevelClass.classNo}');
              }
            });
          },
          hint: Text(
            "Pilih kelas!",
          ),
          items: model.classes.map((value) {
            return DropdownMenuItem<Class>(
              value: value,
              child: Text(
                value.classNo,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDropDownSession(AppModelV2 model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.all(10),
        width: 110,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: DropdownButton<Session>(
          value: selectSessions,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              selectSessions = newValue;
            });
          },
          hint: Text("Pilih Sesi!"),
          items: model.sessions.map((value) {
            return DropdownMenuItem<Session>(
              value: value,
              child: Text(
                value.name,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget addParentCourse(double tab) {
    return Container(
      margin: EdgeInsets.fromLTRB(tab, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.add_circle_outline),
        title: Text('Tambah Pelajaran'),
      ),
    );
  }


  CourseCard _getCourse({@required Course course, double tap}) =>
      CourseCard(fileName: course.courseName.toString(), left: tap);

  Widget _buildPageContent(AppModelV2 model) {
    return Scaffold(
        appBar: _buildAppBar(model),
        resizeToAvoidBottomPadding: false,
        floatingActionButton:
            listCourses != null ? _buildFloatingActionButton(model) : Text(''),
        body: Container(
          child: Column(
            children: <Widget>[
              _buildDropDownClassLevel(model),
              showSessions==true ?_buildDropDownSession(model) : Text(''),
            ],
          ),
        ));
  }

  Widget _buildFloatingActionButton(AppModelV2 model) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
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

