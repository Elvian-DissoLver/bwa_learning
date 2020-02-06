import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/Student.dart';
import 'package:bwa_learning/models/talim/StudentProgress.dart';
import 'package:bwa_learning/models/talim/Topic.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/InfoDialog.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class TeacherUpdateStudentProgress extends StatefulWidget {
  final AppModelV2 model;

  TeacherUpdateStudentProgress(this.model);

  @override
  State<StatefulWidget> createState() {
    return _TeacherUpdateStudentProgressState();
  }
}

class _TeacherUpdateStudentProgressState
    extends State<TeacherUpdateStudentProgress> {
  Class selectLevelClass;
  Topic selectTopic;
  bool showTopics = false;
  bool showNewStudentData = false;
  bool showStudentProgress = false;
  bool showPostButton = false;
  bool showPutButton = false;
  bool isInVal = false;
  var userStatus = List<bool>();
  int institutionId;
  var dateNow;
  List<StudentProgress> studentProgressList;

  @override
  void initState() {
    institutionId = widget.model.currentInstitution.institutionId;
    dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    print(DateTime.now());
    print(dateNow);

    widget.model.fetchClassByInstitutionId(institutionId);

    super.initState();
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Update Perkembangan Murid',
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
            model
                .fetchTopicByCompanyIdAndKeyword(institutionId, '1')
                .then((onValue) {
              if (onValue) {
                setState(() {
                  showTopics = true;
                });
              } else {
                return MessageDialog.show(context, 'Tidak ditemukan',
                    'Belum tersedia data untuk kelas ${selectLevelClass.classNo}');
              }
            }).catchError((onError) {
              MessageDialog.show(
                  context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
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

  Widget _buildDropDownTopic(AppModelV2 model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.all(10),
        width: 200,
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
        child: DropdownButton<Topic>(
          value: selectTopic,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              selectTopic = newValue;
            });

            model
                .fetchStudentByInstitutionId(institutionId)
                .catchError((onError) {
              MessageDialog.show(
                  context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
            });

            model
                .fetchStudentProgressByClassIdAndTopicID(
                    selectLevelClass.classId, selectTopic.topicID)
                .then((onValue) {
              if (onValue) {
                setState(() {
                  showStudentProgress = true;
                });
              } else {
                return MessageDialog.show(context, 'Tidak ditemukan',
                    'Data student progress belum tersedia untuk kelas ini');
              }
            }).catchError((onError) {
              MessageDialog.show(
                  context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
              setState(() {
                model.setLoading(false);
              });
            });
          },
          hint: Text("Pilih Sesi!"),
          items: model.topics.map((value) {
            return DropdownMenuItem<Topic>(
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

  Widget _buildListViewBuilder(AppModelV2 model, BuildContext context,
      int index, StudentProgress studentProgress, Student studentData) {
    return GestureDetector(
      onTap: () {},
      child: studentData != null
          ? Container(
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
                  onTap: () {},
                  child: studentProgressCard(
                      model, studentProgress, studentData, index),
                ),
              ))
          : Container(),
    );
  }

  Widget _buildResultSearch(AppModelV2 model) {
    print('Result');
    studentProgressList = new List();
    return Expanded(
        child: new ListView.builder(
      shrinkWrap: true,
      itemCount: model.studentProgresses.length,
      itemBuilder: (BuildContext context, int index) {
        print(index);
        StudentProgress studentProgress = model.studentProgresses[index];
        int indexStudent =
            model.students.indexWhere((t) => t.id == studentProgress.studentID);
        print('find');
        if (indexStudent > -1) {
          print('indexStudent: $indexStudent');
          studentProgressList.add(studentProgress);
          studentProgressList[index].submittedDate = dateNow;
        }
        Student studentData =
            indexStudent != -1 ? model.students[indexStudent] : null;
        print(studentData.fullName);
        return _buildListViewBuilder(
            model, context, index, studentProgress, studentData);
      },
    ));
  }

  Widget studentProgressCard(AppModelV2 model, StudentProgress studentProgress,
      Student studentData, int index) {
    print('index: ' + index.toString());
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
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
            Text(
                '${studentData.fullName.trim().length <= 20 ? studentData.fullName.trim() : studentData.fullName.trim().substring(0, 20) + '...'}',
                style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontSize: 17,
                    color: Colors.black)),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap: () => editScore(model, studentProgress, studentData, index),
                child: Column(
                  children: <Widget>[
                    Text('Skor'),
                    SizedBox(height: 7,),
                    Center(
                      child: Tooltip(
                        preferBelow: false,
                        waitDuration: Duration(microseconds: 2),
                        message: 'Tap to edit',
                        child: Text(
                          '${studentProgressList[index].quantitativeScore}',
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ));
  }

  editScore(AppModelV2 appModel, StudentProgress studentProgress, Student studentData, int index) {
    Alert(
        context: context,
        title: "Edit Skor",
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
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
                Text(
                    '${studentData.fullName.trim().length <= 20 ? studentData.fullName.trim() : studentData.fullName.trim().substring(0, 20) + '...'}',
                    style: TextStyle(
                        fontFamily: 'ZillaSlab',
                        fontSize: 17,
                        color: Colors.black)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  studentProgressList[index].quantitativeScore = value.replaceFirst(RegExp(','), '.');
                  showPutButton = true;
                });

                print(studentProgressList[index].quantitativeScore);
              },
              inputFormatters: [
                WhitelistingTextInputFormatter(
                    RegExp(r"^(?=.*[1-9])\s*\d*[.]?\d{0,2}\s*$"))
              ],
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              controller: new TextEditingController(
                  text: studentProgress.quantitativeScore),
              decoration: InputDecoration(
                  labelText: 'Skor',
                  contentPadding: EdgeInsets.only(
                      left: 1.0, top: 2.0, right: 1.0, bottom: 5.0)),
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

  Widget _buildPageContent(AppModelV2 model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          _buildDropDownClassLevel(model),
          showTopics ? _buildDropDownTopic(model) : Container(),
          showStudentProgress ? _buildResultSearch(model) : Container(),
        ],
      ),
      floatingActionButton: showPostButton
          ? _buildFloatingPostButton(model)
          : showPutButton ? _buildFloatingPutButton(model) : Container(),
    );
  }

  Widget _buildFloatingPostButton(AppModelV2 model) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Tambah data'),
      onPressed: () {
//        InfoDialog('Anda yakin untuk menambah data?', () => {
//          model.addSessionAbsence(sessionAbsenceList).then((onValue) {
//            if(onValue) {
//              SuccessDialog('Data telah berhasil diperbarui', () {
//                setState(() {
//                  showPostButton = false;
//                });
//              }).show(context);
//            } else {
//              MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
//            }
//          })
//        }).show(context);
      },
    );
  }

  Widget _buildFloatingPutButton(AppModelV2 model) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.system_update_alt),
      label: Text('Perbarui data'),
      onPressed: () {
        InfoDialog('Anda yakin untuk memperbarui data?', () => {
          model.updateStudentProgresses(studentProgressList).then((onValue) {
            if(onValue) {
              SuccessDialog('Data telah berhasil diperbarui', () {
                setState(() {
                  showPutButton = false;
                });
              }).show(context);
            } else {
              MessageDialog.show(
                  context, 'Terjadi kesalahan ', 'Coba ulangi lagi!');
            }
          }).catchError((onError){
            MessageDialog.show(
                context, 'Terjadi kesalahan $onError', 'Coba ulangi lagi!');
            setState(() {
              model.setLoading(false);
            });
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
