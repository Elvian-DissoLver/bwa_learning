import 'package:bwa_learning/models/Class.dart';
import 'package:bwa_learning/models/Course.dart';
import 'package:bwa_learning/models/Teacher.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'CourseList.dart';

// ignore: must_be_immutable
class AddNewCourse extends StatefulWidget {
  final level;
  final levelClass;
  AppModel model;

  AddNewCourse(
    this.level,
    this.levelClass,
    this.model
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNewCourseState();
  }
}

class _AddNewCourseState extends State<AddNewCourse> {

  final Map<String, dynamic> _formData = {
    'courseName': null,
    'teacherId': null,
    'level': null,
    'institutionId': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController courseName = TextEditingController();
  TextEditingController teacherName = TextEditingController();

  bool courseNameExist = false;

  bool _validate = false;

  Course currentCourse;

  Teacher selectTeacher;

  @override
  void initState() {
    setState(() {

      widget.model.fetchTeacherByInstitutionId(widget.model.currentInstitution.institutionId);

      currentCourse = Course(
          courseName: '', level: null, teacherId: null, institutionId : null);
    });

    super.initState();

    courseName.addListener(_validateLatestValue);
  }

  _validateLatestValue() {
    print("first text field: ${courseName.text}");
    print("Second text field: ${teacherName.text}");

    setState(() {
      courseNameExist = false;
      _validate = false;
    });
  }

  Widget _buildTeacherDropDownField(AppModel model) {

    return DropdownButton<Teacher>(
      value: selectTeacher,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        setState(() {
          selectTeacher = newValue;
        });
      },
      hint: Text(
        "Pilih tenaga pengajar!",
      ),
      items: model.teachers
          .map((value) {
        return DropdownMenuItem<Teacher>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(FontAwesomeIcons.userGraduate),
              SizedBox(width: 200),
              Text(
                '${value.fullName}',
              ),
            ],
          ),
        );
      })
          .toList(),
    );
  }

//  _searchClassName(AppModel model) {
//    widget.model.findClassByName(className.text).then((bool success) {
//      if (success) {
//        setState(() {
//          classNameExist = true;
//          _validate = true;
//        });
//      } else {
//        widget.model.createClass(currentClass).then((bool success) {
//          if (success) {
//            widget.model.setCurrentClass(currentClass);
//            SuccessDialog(
//              'Pelajaran ${currentClass.className} berhasil dibuat',
//              () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => CourseList(model),
//                  ),
//                );
//              }
//            ).show(context);
//          } else {
//            MessageDialog.show(
//                context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
//          }
//        });
//      }
//    });
//  }

  void _handlingSaving(AppModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      currentCourse.courseName = courseName.text;
      currentCourse.level = widget.level;
      currentCourse.institutionId = model.currentInstitution.institutionId;
      currentCourse.teacherId = selectTeacher.teacherId;
      print(selectTeacher.teacherId);
    });

//    _searchClassName(model);
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Tambah Pelajaran di Kelas ${widget.levelClass}',
      ),
    );
  }

  Widget _buildCourseNameField() {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 40,
          child: TextFormField(
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.pinkAccent)),
//            icon: Icon(Icons.class_),
                  labelText: 'Nama Pelajaran',
                  hintText: 'eg. Fisika, Matematika',
                  contentPadding: EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
              validator: (value) => value.isEmpty
                  ? 'Mohon isi kolom nama pelajaran'
                  : courseNameExist == true ? 'Pelajaran sudah ada' : null,
              onSaved: (value) {
                _formData['className'] = value;
              },
              controller: courseName),
        ),
        Text(
          '   - ${widget.levelClass}',
          style: TextStyle(
            fontFamily: 'ZillaSlab',
            fontSize: 18,
            color: Colors.black,
          ),
        )

      ],
    );
  }


  Widget _buildPageContent(AppModel model) {
    return Scaffold(
        appBar: _buildAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Container(
          child: Center(
            child: Container(
              width: 300,
              child: Form(
                key: _formKey,
                autovalidate: _validate,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    _buildCourseNameField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTeacherDropDownField(model),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        DialogButton(
                          width: 80,
                          onPressed: () => _handlingSaving(model),
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
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
