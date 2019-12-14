import 'package:bwa_learning/models/Student.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/admin/student/StudentCard.dart';
import 'package:bwa_learning/widgets/dialog/InfoDialog.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
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

  _handlingSearch() async {
    setState(() {
      _isStudentFound = false;
      selectStudent = null;
    });

    if (_controller.text.isEmpty) {
      return MessageDialog.show(
          context, 'Tidak ditemukan', 'Masukkan minimal satu karakter');
    }

    await widget.model
        .fetchStudentByPhone(_controller.text)
        .then((bool success) {
      if (success) {
        setState(() {
          _isStudentFound = true;
        });
      }
    });
  }

  _checkUpdateClassStudent(AppModel model) async{
    if(selectStudent.idClass != null) {
      await widget.model.findClassById(selectStudent.idClass).then((bool success) {
        if(success) {
          InfoDialog(
              '${selectStudent.fullName} sudah berada di Kelas ${model.searchClass.className}. Apakah anda mau melanjutkan proses?',
                  () => _prosesUpdateClassStudent(model)
          ).show(context);
        }
        else {
          _prosesUpdateClassStudent(model);
        }
      });
    }
    else {
      _prosesUpdateClassStudent(model);
    }
  }

  _updateClassStudent(AppModel model) async {
    _checkUpdateClassStudent(model);
  }

  _prosesUpdateClassStudent(AppModel model) async {
    setState(() {
      selectStudent.idClass = model.currentClass.idClass;
    });

    await widget.model.updateStudent(selectStudent).then((bool success) {
      if(success) {
        SuccessDialog(
            '${selectStudent.fullName} berhasil ditambahkan ke Kelas ${model.currentClass.className}',
                () {
              setState(() {
                _isStudentFound = false;
                selectStudent = null;
              });
            }).show(
          context,
        );
      } else {
        MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
      }
    });
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
//      appBar: _buildAppBar(model),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Container(
          child: Column(
            children: <Widget>[
              _buildSearchStudent(),
              _isStudentFound
                  ? Text('${model.foundedStudent.length} data ditemukan')
                  : Text(''),
              _buildResultSearch(model)
            ],
          ),
        ));
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

  Widget _buidSelectedStudent(AppModel model) {
    return Positioned(
      child: Column(
        children: <Widget>[
          StudentCard(selectStudent),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            color: Colors.greenAccent,
            icon: Icon(Icons.add_circle_outline),
            label: 'Tambah Siswa',
            onPressed: () => _updateClassStudent(model),
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
                    itemCount: model.foundedStudent.length,
                    itemBuilder: (BuildContext context, int index) {
                      Student student = model.foundedStudent[index];
                      String listData = student.fullName + ', ' + student.noHp;
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectStudent = Student(
                                  idStudent: student.idStudent,
                                  fullName: student.fullName,
                                  idClass: student.idClass,
                                  idInstitution: student.idInstitution,
                                  noHp: student.noHp,
                                  email: student.email);
                              _controller.clear();
                              _isStudentFound = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.green),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text(listData)
                              ],
                            ),
                          ));
                    },
                  )
                : new ListView.builder(
                    shrinkWrap: true,
                    itemCount: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile();
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
            selectStudent != null
                ? _buidSelectedStudent(model)
                : SizedBox(height: 20)
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
