
class StudentProgress {
  int studentProgressID;
  int classID;
  int topicID;
  int studentID;
  int institutionId;
  int instructorId;
  String quantitativeScore;
  var submittedDate;

  StudentProgress({
    this.studentProgressID,
    this.classID,
    this.topicID,
    this.studentID,
    this.institutionId,
    this.instructorId,
    this.quantitativeScore,
    this.submittedDate
  });

  StudentProgress.fromJson(Map<String, dynamic> map) {
    studentProgressID = map['ID'];
    classID = map['id_classes'];
    topicID = map['TopicID'];
    studentID = map['id_student'];
    institutionId = map['InstitutionID'];
    instructorId = map['id_instructor'];
    quantitativeScore = map['QuantitativeScore'].toString();
    submittedDate = map['submitteddate'];
    print('done');
  }
}
