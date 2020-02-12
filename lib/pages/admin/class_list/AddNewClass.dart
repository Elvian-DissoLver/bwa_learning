import 'package:bwa_learning/models/origin/Class.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ClassList.dart';

// ignore: must_be_immutable
class AddNewClass extends StatefulWidget {
  final level;
  AppModel model;

  AddNewClass(
    this.level,
    this.model,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNewClassState();
  }
}

class _AddNewClassState extends State<AddNewClass> {
  List _cities = [
    "Cluj-Napoca",
    "Bucuresti",
    "Timisoara",
    "Brasov",
    "Constanta"
  ];

  final Map<String, dynamic> _formData = {
    'className': null,
    'teacherClass': null,
    'level': null,
    'institutionId': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController className = TextEditingController();
  TextEditingController teacherClass = TextEditingController();

  bool classNameExist = false;

  bool _validate = false;

  Class currentClass;

  @override
  void initState() {
    setState(() {

      currentClass = Class(
          className: '', level: null, teacherClass: '', institutionId: null);
    });

    super.initState();

    className.addListener(_validateLatestValue);
  }

  _validateLatestValue() {
    print("first text field: ${className.text}");
    print("Second text field: ${teacherClass.text}");

    setState(() {
      classNameExist = false;
      _validate = false;
    });
  }

  _searchClassName(AppModel model) {
    widget.model.findClassByName(className.text).then((bool success) {
      if (success) {
        setState(() {
          classNameExist = true;
          _validate = true;
        });
      } else {
        widget.model.createClass(currentClass).then((bool success) {
          if (success) {
            widget.model.setCurrentClass(currentClass);
            SuccessDialog(
              'Kelas ${currentClass.className} berhasil dibuat',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassList(model),
                  ),
                );
              }
            ).show(context);
          } else {
//            MessageDialog.show(
//                context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
          }
        });
      }
    });
  }

  void _handlingSaving(AppModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      currentClass.className = className.text;
      currentClass.teacherClass = teacherClass.text;
      currentClass.level = widget.level;
      currentClass.institutionId = 1234;
    });

    _searchClassName(model);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Tambah Kelas',
      ),
    );
  }

  Widget _buildClassNameField() {
    return TextFormField(
        decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.pinkAccent)),
            icon: Icon(Icons.class_),
            labelText: 'Nama Kelas',
            hintText: 'eg. X-A, XI-IPA-1',
            contentPadding: EdgeInsets.only(
                left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
        validator: (value) => value.isEmpty
            ? 'Mohon isi kolom nama kelas'
            : classNameExist == true ? 'Kelas sudah ada' : null,
        onSaved: (value) {
          _formData['className'] = value;
        },
        controller: className);
  }

  Widget _buildWMNameField() {
    return TextFormField(
      controller: teacherClass,
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.pinkAccent)),
          icon: Icon(FontAwesomeIcons.userGraduate),
          labelText: 'Wali Kelas',
          hintText: 'eg. Akel, S.Pd',
          contentPadding:
              EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
      validator: (value) => value.isEmpty ? 'Mohon isi kolom wali kelas' : null,
      onSaved: (value) {
        _formData['teacherClass'] = value;
      },
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
                    _buildClassNameField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildWMNameField(),
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
