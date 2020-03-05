import 'package:bwa_learning/models/talim/Class.dart';
import 'package:bwa_learning/models/talim/Student.dart';
import 'package:bwa_learning/models/talim/StudentProgress.dart';
import 'package:bwa_learning/models/talim/Topic.dart';
import 'package:bwa_learning/models/talim/TrainingClass.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:bwa_learning/widgets/dialog/InfoDialog.dart';
import 'package:bwa_learning/widgets/dialog/MessageDialog.dart';
import 'package:bwa_learning/widgets/dialog/SuccessDialog.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailUpdateLessonProgress extends StatefulWidget {
  final AppModelV2 model;
  final TrainingClass trainingClass;
  final Class selectedClass;
  final Topic topic;

  DetailUpdateLessonProgress(
      this.model, this.trainingClass, this.selectedClass, this.topic);

  @override
  State<StatefulWidget> createState() {
    return _DetailUpdateLessonProgressState();
  }
}

class _DetailUpdateLessonProgressState
    extends State<DetailUpdateLessonProgress> {
  bool showSaveButton = false;
  bool showIndicator = false;
  bool showResultIndicator = false;
  var rating;
  int institutionId;
  var dateNow;
  List<StudentProgress> studentProgressList;
  TextEditingController percentScore = new TextEditingController();
  TextEditingController comment = new TextEditingController();

  @override
  void initState() {
    institutionId = widget.model.currentInstitution.institutionId;
    dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    print(DateTime.now());
    print(dateNow);

    widget.model
        .fetchInstructorById(widget.selectedClass.instructorId)
        .catchError((onError) {
      MessageDialog.show(context, 'Terjadi kesalahan $onError',
          'Coba ulangi lagi!', () => Navigator.pushNamed(context, '/'));
      setState(() {
        widget.model.setLoading(false);
      });
    });

    percentScore.text =
        (widget.model.currentStudentProgress.studentPercentSense * 100)
            .toString();
    comment.text =
        widget.model.currentStudentProgress.studentComment.toString();

    percentScore.addListener(currencyInputFormatter);

    super.initState();
  }

  Widget _buildAppBar(AppModelV2 model) {
    return AppBar(
      title: Text(
        'Update Perkembangan Murid',
      ),
      automaticallyImplyLeading: false,
    );
  }

  editScore(AppModelV2 appModel, StudentProgress studentProgress,
      Student studentData, int index) {
    percentScore.text = studentProgressList[index].quantitativeScore;
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
                  studentProgressList[index].quantitativeScore =
                      percentScore.text;
                  showSaveButton = true;
                });

                print(studentProgressList[index].quantitativeScore);
              },
              inputFormatters: [
                WhitelistingTextInputFormatter(
                    RegExp(r"^(?=.*[1-9])\s*\d*[.]?\d{0,2}\s*$")),
              ],
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              controller: percentScore,
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

  currencyInputFormatter() {
    print('percent: ' + percentScore.text);
    showIndicator = false;
    showResultIndicator = false;
    print('showIndicator: ' + showIndicator.toString());
    if (percentScore.text.length < 1) {
      percentScore.text = '';
      showIndicator = false;
      showResultIndicator = false;
      print('loop');
    } else {
      if (double.parse(percentScore.text) > 100) {
        percentScore.text = '';
      } else if (percentScore.text.length > 1 &&
          double.parse(percentScore.text) < 10) {
        percentScore.text = '';
      } else if (double.parse(percentScore.text) == 0.0) {
        percentScore.text = '';
      }
      showIndicator = true;
    }
  }

  Widget _teacherCard(AppModelV2 model) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
        height: 70,
        width: MediaQuery.of(context).size.width - 16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Container(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pengajar',
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
                    model.currentInstructor != null
                        ? model.currentInstructor.name
                        : '',
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
        ));
  }

  Widget _buildIndicator(AppModelV2 model) {
    showResultIndicator = true;
    double percent =
        percentScore.text.length < 1 ? 0.0 : double.parse(percentScore.text);
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: new LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 1000,
        percent: percent * 0.01,
        center: Text('$percent %'),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: percent > 80.0
            ? Colors.greenAccent
            : percent < 80.0 && percent > 60.0
                ? Colors.lightGreenAccent
                : Colors.redAccent,
      ),
    );
  }

  Widget _buildInputUnderstanding(AppModelV2 model) {
    return Container(
      width: 180,
      child: TextField(
        onChanged: (value) {
          showSaveButton = true;
          model.currentStudentProgress.studentPercentSense =
              double.parse(percentScore.text) * 0.01;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp(r"^(?=.*[1-9])\s*\d*[.]?\d{0,2}\s*$")),
        ],
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        controller: percentScore,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            labelText: 'Tingkat Pemahaman',
            hintText: 'eg. 0-100',
            contentPadding:
                EdgeInsets.only(left: 10.0, top: 2.0, right: 1.0, bottom: 5.0)),
      ),
    );
  }

  Widget _buildIndicatorResultText() {
    double percent = percentScore.text.length < 1
        ? 0.0
        : double.parse(percentScore.text) * 100;
    return Text(
      percent > 80.0
          ? 'Sangat Paham'
          : percent < 80.0 && percent > 60.0 ? 'Paham' : 'Kurang Paham',
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: percent > 80.0
              ? Colors.greenAccent
              : percent < 80.0 && percent > 60.0
                  ? Colors.lightGreenAccent
                  : Colors.redAccent),
    );
  }

  Widget _buildRatingTeach() {
    return SmoothStarRating(
        allowHalfRating: false,
        onRatingChanged: (v) {
          setState(() {
            rating = v;
            showSaveButton = true;
          });
        },
        starCount: 5,
        rating: rating != null ? rating : 0,
        size: 40.0,
        color: Colors.green,
        borderColor: Colors.green,
        spacing: 0.0);
  }

  Widget _buildComment(AppModelV2 model) {
    return Container(
      width: 325,
      child: TextField(
        onChanged: (value) {
          showSaveButton = true;
          model.currentStudentProgress.studentComment = comment.text;
        },
        controller: comment,
        maxLines: 6,
        decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(),
            ),
            labelText: 'Komentar',
            contentPadding:
                EdgeInsets.only(left: 10.0, top: 2.0, right: 1.0, bottom: 5.0)),
      ),
    );
  }

  Widget _buildFloatingSaveButton(AppModelV2 model) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.save),
      label: Text('Simpan data'),
      onPressed: () {
        InfoDialog(
            'Anda yakin untuk menambah data?',
            () => {
                  model
                      .updateStudentProgressByStudent(
                          model.currentStudentProgress)
                      .then((onValue) {
                    if (onValue) {
                      SuccessDialog('Data telah berhasil diperbarui', () {
                        setState(() {
                          showSaveButton = false;
                        });
                      }).show(context);
                    } else {
                      MessageDialog.show(
                          context,
                          'Terjadi kesalahan',
                          'Coba ulangi lagi!',
                          () => Navigator.of(context).pop());
                    }
                  }).catchError((onError) {
                    MessageDialog.show(context, 'Terjadi kesalahan $onError',
                        'Coba ulangi lagi!', () => Navigator.of(context).pop());
                    setState(() {
                      model.setLoading(false);
                    });
                  })
                }).show(context);
      },
    );
  }

  Widget _buildPageContent(AppModelV2 model, BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(model),
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  widget.trainingClass.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(height: 20),
                Text(
                  widget.topic.name,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 20),
                _teacherCard(model),
                SizedBox(height: 30),
                _buildInputUnderstanding(model),
                showIndicator ? _buildIndicator(model) : Container(),
                showResultIndicator ? _buildIndicatorResultText() : Container(),
                SizedBox(height: 30),
                _buildRatingTeach(),
                SizedBox(height: 30),
                _buildComment(model),
              ],
            )
          ],
        ),
      ),
      floatingActionButton:
          showSaveButton ? _buildFloatingSaveButton(model) : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModelV2>(
      builder: (BuildContext context, Widget child, AppModelV2 model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model, context),
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
