class Class {
  int classId;
  String classNo;
  int instructorId;
  int trainingClassID;
  int timeScheduleID;
  int schoolPackageID;

  Class(
      {this.classId,
      this.classNo,
      this.instructorId,
      this.trainingClassID,
      this.timeScheduleID,
      this.schoolPackageID});

  Class.fromJson(Map<String, dynamic> map) {
    classId = map['id_classes'];
    classNo = map['ClassNo'];
    instructorId = map['id_instructor'];
    trainingClassID = map['TrainingClassID'];
    timeScheduleID = map['TimeScheduleID'];
    schoolPackageID = map['SchoolPackageID'];
  }
}
