import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/helper/MessageDialog.dart';
import 'package:bwa_learning/widgets/helper/SuccessDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNewClass extends StatefulWidget {
  final level;

  AddNewClass(
    this.level,
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

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  final Map<String, dynamic> _formData = {
    'className': null,
    'teacherClass': null,
    'level': null,
    'idInstitution': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController className = TextEditingController();
  TextEditingController teacherClass = TextEditingController();

  bool classNameExist = true;

  bool _validate = false;

  Kelas currentKelas;

  @override
  void initState() {
    setState(() {
      _dropDownMenuItems = getDropDownMenuItems();
      _currentCity = _dropDownMenuItems[0].value;

      currentKelas = Kelas(
        className: '',
        level: null,
        teacherClass: '',
        idInstitution: ''
      );

    });

    super.initState();

    className.addListener(_printLatestValue);
    teacherClass.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("first text field: ${className.text}");
    print("Second text field: ${teacherClass.text}");

//    _formKey.currentState.validate();
    setState(() {
      _validate = true;
    });
  }


  void _authenticate(AppModel model) async {

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      currentKelas.className = className.text;
      currentKelas.teacherClass = teacherClass.text;
      currentKelas.level = widget.level;
      currentKelas.idInstitution = '1234';
    });
    
    await model.createKelas(currentKelas)
        .then((bool success) {
      if (success) {
        model.setCurrentKelas(currentKelas);
        SuccessDialog().show(context, model, 'Kelas ${currentKelas.className} berhasil dibuat');
      } else {
        MessageDialog.show(context);
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  Widget _addNewClass(AppModel appModel) {
    Alert(
        context: context,
        title: "Tambah Kelas",
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            new DropdownButton(
              value: _currentCity,
              items: _dropDownMenuItems,
              onChanged: _changedDropDownItem,
            ),
            TextField(
//                  autofocus: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.pinkAccent)),
//                  icon: Icon(Icons.account_circle),
                  labelText: 'Nama Kelas',
                  contentPadding: EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.pinkAccent)),
                  icon: Icon(Icons.lock),
                  labelText: 'Wali Kelas',
                  contentPadding: EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            width: 80,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ]).show();
  }

  _changedDropDownItem(String selectedCity) {
    print(selectedCity);
    setState(() {
      _currentCity = selectedCity;
    });
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
          contentPadding:
              EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)
      ),
      validator: (value) => value.isEmpty ? 'Mohon isi kolom nama kelas' :
//                            classNameExist? 'Kelas sudah ada' :
                            null,
      onSaved: (value) {
        _formData['className'] = value;
      },
      controller: className
    );
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
              EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0))
      ,
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
                          onPressed: () => _authenticate(model),
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

        return stack;
      },
    );
  }
}
