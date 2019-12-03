import 'package:bwa_learning/models/Student.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/admin/student/StudentCard.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:bwa_learning/widgets/ui_elements/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNewStudentClass extends StatefulWidget {
  AppModel model;

  AddNewStudentClass(
    this.model,
  );

  @override
  State<StatefulWidget> createState() {
    return _AddNewStudentClassState();
  }
}

class _AddNewStudentClassState extends State<AddNewStudentClass> {

  Student selectStudent;

  final globalKey = new GlobalKey<ScaffoldState>();

  TextEditingController _controller = new TextEditingController();

  bool _isStudentFound = false;


  @override
  void initState() {

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Siswa',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
//      appBar: _buildAppBar(model),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      key: globalKey,
      body: Container(
            child: Column(
              children: <Widget>[
                _buildSearchStudent(),
                _buildResultSearch(model)
              ],
            ),
      )
    );
  }

  Widget _buildSearchStudent() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 46),
      child: Theme(
        data: ThemeData(
          hintColor: Colors.transparent,
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Cari siswa berdasarkan no.Hp',
            hintStyle: TextStyle(
              color: Colors.black26,
              fontSize: 14,
              fontFamily: 'Medium',
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.black,
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            contentPadding: EdgeInsets.all(12),
            suffixIcon: IconButton(
              icon: Icon(FontAwesomeIcons.search, size: 15),
              color: Color(0xffb4c2d3),
              onPressed: () => _handlingSearch(),
            ),
          ),
        ),
      ),
    );
  }

  _handlingSearch() async {
    print('ok');

    setState(() {
      _isStudentFound = false;
      selectStudent = null;
    });


    widget.model.fetchStudentByPhone(_controller.text)
        .then((bool success) {
      if (success) {
        setState(() {
          _isStudentFound = true;
        });
      }
    });
  }

  Widget _buidSelectedStudent(AppModel model) {
    return Positioned(
      child: Column(
        children: <Widget>[
          StudentCard(selectStudent),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            color:  Colors.greenAccent,
            icon: Icon(Icons.add_circle_outline),
            label: 'Tambah Siswa',
            onPressed: () {},
          )
        ],
      ),
      top: 200,
    );
  }

  Widget _buildResultSearch(AppModel model) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Flexible(
              child: _isStudentFound && _controller.text.isNotEmpty
                  ? new ListView.builder(
                shrinkWrap: true,
                itemCount: model.students.length,
                itemBuilder: (BuildContext context, int index) {
                  Student student = model.students[index];
                  String listData = student.fullName+', '+student.noHp;
                  return new ListTile(
                    title: new Text(listData.toString()),
                    onTap: () {
                      print(model.students[index].fullName);

                      setState(() {
                        selectStudent = Student(
                            idStudent: model.students[index].idStudent,
                            fullName: model.students[index].fullName,
                            idKelas: model.students[index].idKelas,
                            idInstitution: model.students[index].idInstitution,
                            noHp: model.students[index].noHp,
                            email: model.students[index].email
                        );
                        _controller.clear();
                        _isStudentFound = false;
                      });

                    },
                    trailing: Icon(
                      Icons.arrow_forward
                    ),
                  );
                },
              )
              : new ListView.builder(
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                  );
                },
              ))
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
            selectStudent!=null ? _buidSelectedStudent(model): SizedBox(height: 20)

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

