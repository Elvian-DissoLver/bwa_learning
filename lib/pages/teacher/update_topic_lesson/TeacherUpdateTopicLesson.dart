import 'dart:math';
import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/LinkTrainingMeetingTopic.dart';
import 'package:bwa_learning/models/talim/Session.dart';
import 'package:bwa_learning/models/talim/SessionAbsence.dart';
import 'package:bwa_learning/models/talim/Topic.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/InfoDialog.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tree_view/tree_view.dart';

class TeacherUpdateTopicLesson extends StatefulWidget {
  final AppModelV2 model;

  TeacherUpdateTopicLesson(this.model);

  @override
  State<StatefulWidget> createState() {
    return _TeacherUpdateTopicLessonState();
  }
}

class _TeacherUpdateTopicLessonState extends State<TeacherUpdateTopicLesson> {
  Class selectLevelClass;
  Session selectSessions;
  bool showSessions = false;
  bool showNewStudentData = false;
  bool showStudentData = false;
  bool showTopicData = false;
  bool showNewTopicData = false;
  bool showPostButton = false;
  bool showPutButton = false;
  bool isInVal = false;
  var userStatus = List<bool>();
  var topicStatus = List<bool>();
  int institutionId;
  var dateNow;
  List<SessionAbsence> sessionAbsenceList;
  List<LinkTrainingMeetingTopic> ltmTopic;
  int index = 0;

  @override
  void initState() {
    institutionId = widget.model.currentInstitution.institutionId;
    dateNow = DateFormat('yyyy-MM-D').format(DateTime.now());

    widget.model.fetchClassByInstitutionId(
        institutionId);

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
              if (onValue) {
                setState(() {
                  showSessions = true;
                });
              } else {
                return MessageDialog.show(context, 'Tidak ditemukan',
                    'Belum tersedia Sesi untuk kelas ${selectLevelClass.classNo}');
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
                .fetchLinkTrainingMeetingTopicByTrainingSessionId(selectSessions.trainingSessionID)
                .then((onValue) {
              if (onValue) {
                setState(() {
                  showTopicData = true;
                });
                model.fetchTopicByCompanyIdAndKeyword(institutionId,'1');
              } else {
                model.fetchTopicByCompanyIdAndKeyword(institutionId,'1').then((onValue) {
                  if(onValue) {
                    showNewTopicData = true;
                  } else {
                    return MessageDialog.show(context, 'Tidak ditemukan',
                        'Data Topik belum tersedia untuk Sesi ini');
                  }

                });
              }
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

  List<Widget> _buildNewTopicParentList(
      AppModelV2 model, List<Topic> topics, int parentId, double tab) {
    print('new');
    List<Topic> parent = new List();
    List<Topic> member = new List();

    topics.forEach((f) {
      if (f.parentTopicID == parentId) {
        print(f.name);
        parent.add(f);
      }
    });

    return parent.map((p) {
      widget.model.topics.forEach((c) {
        if (c.parentTopicID == p.topicID) {
          member.add(c);
        }
      });

      topicStatus.add(false);
      LinkTrainingMeetingTopic linkTrainingMeetingTopic = new LinkTrainingMeetingTopic(
        id: Random.secure().nextInt(999999),
        trainingSessionID: selectSessions.trainingSessionID,
        dataStatusID: false,
        topicID: p.topicID,

      );

      ltmTopic.add(linkTrainingMeetingTopic);

      return Parent(
          parent: topicCards(model, p, tab, index++),
          childList: ChildList(
              children: _buildNewTopicParentList(model, member, p.topicID, tab + 15)));
    }).toList();
  }

  List<Widget> _buildTopicParentList(
      AppModelV2 model, List<Topic> topics, int parentId, double tab) {
    print('old');
    List<Topic> parent = new List();
    List<Topic> member = new List();

    topics.forEach((f) {
      if (f.parentTopicID == parentId) {
        print(f.name);
        parent.add(f);
      }
    });

    return parent.map((p) {
      widget.model.topics.forEach((c) {
        if (c.parentTopicID == p.topicID) {
          member.add(c);
        }
      });

      int indexLtmTopic = model.linkTrainingMeetingTopics.indexWhere((t) => t.topicID == p.topicID);
      LinkTrainingMeetingTopic linkTrainingMeetingTopic = model.linkTrainingMeetingTopics.elementAt(indexLtmTopic);
      topicStatus.add(linkTrainingMeetingTopic.dataStatusID);
      ltmTopic.add(linkTrainingMeetingTopic);

      return Parent(
          parent: topicCards(model, p, tab, index++),
          childList: ChildList(
              children: _buildTopicParentList(model, member, p.topicID, tab + 15)));
    }).toList();
  }

  Widget topicCards(AppModelV2 model, Topic topic, double tab, index) {
    print('index: ' +index.toString());
    print('topic: ' +topic.name);
    return Container(
        height: 85,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(tab, 5, 5, 5),
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
        child: Row(
          children:[
            Text(
                '${topic.name
                    .trim()
                    .length <= 20 ? topic.name.trim() : topic.name.trim().substring(0, 20) + '...'}',
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
                      'Selesai',
                      style: TextStyle(
                          fontFamily: 'ZillaSlab',
                          fontSize: 14,
                          color: Colors.black
                      )
                  ),
                  Checkbox(
                    value: topicStatus[index],
                    onChanged: (bool value) {
                      setState(() {
                        topicStatus[index] = !topicStatus[index];
                        ltmTopic[index].dataStatusID = topicStatus[index];
                      });
                      print('index 4 value: ${topicStatus[4]}');
                      print('sessionIndex $index: ${ltmTopic[index].dataStatusID}');
                    },
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget _buildNewTopicList(AppModelV2 model) {
    ltmTopic = new List();
    index = 0;
    return Expanded(
      child: TreeView(
        parentList: _buildNewTopicParentList(model, model.topics, 0, 5),
      )
    );
  }

  Widget _buildTopicList(AppModelV2 model) {
    ltmTopic = new List();
    index = 0;
    return Expanded(
        child: TreeView(
          parentList: _buildTopicParentList(model, model.topics , 0, 5),
        )
    );
  }

  Widget _buildPageContent(AppModelV2 model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          _buildDropDownClassLevel(model),
          showSessions ? _buildDropDownSession(model) : Container(),
//          showNewStudentData ? _buildNewResultSearch(model): Container(),
//          showStudentData ? _buildResultSearch(model) : Container(),
          showNewTopicData ? _buildNewTopicList(model) : Container(),
          showTopicData ? _buildTopicList(model) : Container(),
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
              MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
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
              MessageDialog.show(context, 'Terjadi kesalahan', 'Coba ulangi lagi!');
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
