import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/Session.dart';
import 'package:bwa_learning/models/talim/SessionAbsence.dart';
import 'package:bwa_learning/models/talim/Student.dart';
import 'package:bwa_learning/models/talim/TrainingClass.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/InfoDialog.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class TeacherAttendanceList extends StatefulWidget {
  final AppModelV2 model;

  TeacherAttendanceList(this.model);

  @override
  State<StatefulWidget> createState() {

    return _TeacherAttendanceListState();
  }
}

class _TeacherAttendanceListState extends State<TeacherAttendanceList> {
  TrainingClass selectTrainingClass;
  Class selectLevelClass;
  Session selectSessions;
  bool showClass = false;
  bool showSessions = false;
  bool showNewStudentData = false;
  bool showStudentData = false;
  bool showPostButton = false;
  bool showPutButton = false;
  var userStatus = List<bool>();
  int institutionId;
  var dateNow;
  List<SessionAbsence> sessionAbsenceList;

  @override
  void initState() {
    institutionId = widget.model.currentInstitution.institutionId;
    dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    print(DateTime.now());
    print(dateNow);

    widget.model.fetchTrainingClassByCompanyId(institutionId).catchError((onError) {
      MessageDialog.show(context, 'Terjadi kesalahan $onError',
          'Coba ulangi lagi!', ()=> Navigator.pushNamed(context, '/'));
      setState(() {
        widget.model.setLoading(false);
      });
    });

    super.initState();
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Daftar Kehadiran',
      ),
    );
  }

  Widget _buildDropDownTrainingClass(AppModelV2 model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.all(10),
        width: 160,
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
        child: DropdownButton<TrainingClass>(
          value: selectTrainingClass,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              selectTrainingClass = newValue;
              selectLevelClass = null;
              showSessions = false;
              showNewStudentData = false;
              showStudentData = false;
            });
            model.fetchClassByTrainingClassId(selectTrainingClass.trainingClassID).then((onValue) {
              if (onValue) {
                setState(() {
                  showClass = true;
                });
              } else {
                return MessageDialog.show(
                    context,
                    'Tidak ditemukan',
                    'Belum tersedia Kelas untuk MK ${selectLevelClass.classNo}',
                        ()=> Navigator.of(context).pop());
              }
            });
          },
          hint: Text(
            "Pilih mata kuliah!",
          ),
          items: model.trainingClasses.map((value) {
            return DropdownMenuItem<TrainingClass>(
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
              selectSessions = null;
              showNewStudentData = false;
              showStudentData = false;
            });
            model.fetchSessionByClassId(newValue.classId).then((onValue) {
              if (onValue) {
                setState(() {
                  showSessions = true;
                });
              } else {
                return MessageDialog.show(context, 'Tidak ditemukan',
                    'Belum tersedia Sesi untuk kelas ${selectLevelClass.classNo}', () => Navigator.of(context).pop());
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
            model
                .fetchSessionAbsenceByTrainingSessionIdAndDate(
                    selectSessions.trainingSessionID, dateNow)
                .then((onValue) {
              if (onValue) {
                setState(() {
                  showStudentData = true;
                });
              } else {
                model.fetchSessionAbsenceByTrainingSessionId(selectSessions.trainingSessionID).then((onValue) {
                  if (onValue) {
                    setState(() {
                      showNewStudentData = true;
                    });
                  } else{
                    return MessageDialog.show(context, 'Tidak ditemukan',
                        'Data student belum tersedia untuk Sesi ini', () => Navigator.of(context).pop());
                  }
                });
              }
            });
            model.fetchStudentByInstitutionId(institutionId);

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

  Widget _buildListViewBuilder(AppModelV2 model, BuildContext context, int index, SessionAbsence sessionAbsence, Student studentData) {
    return GestureDetector(
      onTap: ()=> Navigator.of(context).pop(),
      child: studentData!=null ? Container(
          margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
          height: 84,
          width: MediaQuery.of(context).size.width - 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {

              },
              child: studentAbsenceCard(model, sessionAbsence, studentData, index),
            ),
          )) : Container(),
    );
  }

  _buildNewResultSearch(AppModelV2 model) {
    print('newResult');
    sessionAbsenceList = new List();
    return Expanded(
        child: new ListView.builder(
          shrinkWrap: true,
          itemCount: model.sessionAbsences.length,
          itemBuilder: (BuildContext context, int index) {
            SessionAbsence sessionAbsence = model.sessionAbsences[index];
            int indexStudent = model.students.indexWhere((t) => t.studentID == sessionAbsence.studentID);
            if(indexStudent > -1) {
              print('indexStudent: $indexStudent');
              userStatus.add(false);
              print('isInStudent $indexStudent: ${userStatus[indexStudent]}');
              sessionAbsenceList.add(sessionAbsence);
              sessionAbsenceList[indexStudent].isIn = userStatus[indexStudent];
              print('isInStudentInList $index: ${sessionAbsenceList[indexStudent].isIn}');
              sessionAbsenceList[indexStudent].date = dateNow;
            }
            Student studentData = indexStudent!=-1 ? model.students[indexStudent] : null;
            return _buildListViewBuilder(model, context, indexStudent, sessionAbsence, studentData);
          },
        ));
  }

  Widget _buildResultSearch(AppModelV2 model) {
    print('Result');
    sessionAbsenceList = new List();
    return Expanded(
        child: new ListView.builder(
      shrinkWrap: true,
      itemCount: model.sessionAbsences.length,
      itemBuilder: (BuildContext context, int index) {
        print(index);
        SessionAbsence sessionAbsence = model.sessionAbsences[index];
        int indexStudent = model.students.indexWhere((t) => t.studentID == sessionAbsence.studentID);
        if(indexStudent > -1) {
          print('indexStudent: $indexStudent');
          userStatus.add(model.sessionAbsences[indexStudent].isIn);
          print('isInStudent $indexStudent: ${userStatus[indexStudent]}');
          sessionAbsenceList.add(sessionAbsence);
          sessionAbsenceList[indexStudent].isIn = userStatus[indexStudent];
          print('isInStudentInList $index: ${sessionAbsenceList[indexStudent].isIn}');
          sessionAbsenceList[indexStudent].date = dateNow;
        }
        Student studentData = indexStudent!=-1 ? model.students[indexStudent] : null;
        return _buildListViewBuilder(model, context, indexStudent, sessionAbsence, studentData);
      },
    ));
  }

  Widget studentAbsenceCard(AppModelV2 model, SessionAbsence sessionAbsence, Student studentData, int index) {
    print('index: ' +index.toString());
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children:[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://source.unsplash.com/ZHvM3XIOHoE" ?? Icons.person_pin
                    )
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
                '${studentData.fullName
                    .trim()
                    .length <= 20 ? studentData.fullName.trim() : studentData
                    .fullName.trim().substring(0, 20) + '...'}',
                style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontSize: 17,
                    color: Colors.black
                )
            ),
            Spacer(),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                      'Masuk',
                      style: TextStyle(
                          fontFamily: 'ZillaSlab',
                          fontSize: 14,
                          color: Colors.black
                      )
                  ),
                  Checkbox(
                    value: userStatus[index],
                    onChanged: (bool value) {
                      setState(() {
                        userStatus[index] = !userStatus[index];
                        sessionAbsenceList[index].isIn = userStatus[index];
                      });
                      print('sessionIndex $index: ${sessionAbsenceList[index].isIn}');
                      model.fetchSessionAbsenceByPersonIdAndDate(sessionAbsence.studentID, dateNow).then((onValue){
                        if(onValue) {
                          setState(() {
                            showPutButton = true;
                          });
                        } else {
                          setState(() {
                            showPostButton = true;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget _buildPageContent(AppModelV2 model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          _buildDropDownTrainingClass(model),
          Row(
            children: <Widget>[
              showClass ? _buildDropDownClassLevel(model) : Container(),
              Spacer(),
              showSessions ? _buildDropDownSession(model) : Container(),
            ],
          ),
          showNewStudentData ? _buildNewResultSearch(model): Container(),
          showStudentData ? _buildResultSearch(model) : Container(),
        ],
      ),
      floatingActionButton:
      showPostButton ? _buildFloatingPostButton(model) :
      showPutButton ? _buildFloatingPutButton(model) : Container(),
    );
  }

  Widget _buildFloatingPostButton(AppModelV2 model) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Tambah data'),
      onPressed: () {
        InfoDialog('Anda yakin untuk menambah data?', () => {
          model.addSessionAbsence(sessionAbsenceList).then((onValue) {
            if(onValue) {
              SuccessDialog('Data telah berhasil diperbarui', () {
                setState(() {
                  showPostButton = false;
                });
              }).show(context);
            } else {
              MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!', () => Navigator.of(context).pop());
            }
          })
        }).show(context);
      },
    );
  }

  Widget _buildFloatingPutButton(AppModelV2 model) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.system_update_alt),
      label: Text('Perbarui data'),
      onPressed: () {
        InfoDialog('Anda yakin untuk memperbarui data?', () => {
          model.updateSessionAbsence(sessionAbsenceList).then((onValue) {
            if(onValue) {
              SuccessDialog('Data telah berhasil diperbarui', () {
                setState(() {
                  showPutButton = false;
                });
              }).show(context);
            } else {
              MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!', () => Navigator.of(context).pop());
            }
          })
        }).show(context);
      },
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
