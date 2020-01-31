
class SessionAbsence {
  int sessionAbsenceID;
  String studentID;
  int trainingSessionID;
  var date;
  bool isIn;

  SessionAbsence({
    this.studentID,
    this.sessionAbsenceID,
    this.trainingSessionID,
    this.isIn,
    this.date
  });

  SessionAbsence.fromJson(Map<String, dynamic> map) {
    sessionAbsenceID = map['ID'];
    studentID = map['PersonID'];
    trainingSessionID = map['TrainingSessionID'];
    isIn = getIsInFromInt(map['IsIn']);
    date = map['Date_'];
  }

  static bool getIsInFromInt(int value) {
    switch(value){
      case 1:
        return true;
      case 0:
        return false;
      default:
        return false;
    }
  }

  static int getIsInFromBool(bool value) {
    switch(value){
      case true:
        return 1;
      case false:
        return 0;
      default:
        return 0;
    }
  }
}
