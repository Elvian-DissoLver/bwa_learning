
class StudentProgress {
  int studentProgressID;
  var classID;
  var topicID;
  int studentID;
  int institutionId;
  int instructorId;
  var quantitativeScore;
  var submittedDate;
  var studentPercentSense;
  var studentComment;

  StudentProgress({
    this.studentProgressID,
    this.classID,
    this.topicID,
    this.studentID,
    this.institutionId,
    this.instructorId,
    this.quantitativeScore,
    this.submittedDate,
    this.studentPercentSense,
    this.studentComment
  });

  StudentProgress.fromJson(Map<String, dynamic> map) {
    studentProgressID = map['ID'];
    classID = map['id_classes'];
    topicID = map['TopicID'];
    studentID = map['id_student'];
    institutionId = map['InstitutionID'];
    instructorId = map['id_instructor'];
    quantitativeScore = map['QuantitativeScore'];
    submittedDate = map['submitteddate'];
    studentPercentSense = map['studentPercentSense'];
    studentComment = map['studentComment'];
  }
}
