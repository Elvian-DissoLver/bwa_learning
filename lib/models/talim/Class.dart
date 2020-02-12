class Class {
  int classId;
  String classNo;
  int instructorId;
  int trainingClassID;
  int timeScheduleID;
  int schoolPackageID;
  var startDateTime;
  var endDateTime;

  Class(
      {this.classId,
      this.classNo,
      this.instructorId,
      this.trainingClassID,
      this.timeScheduleID,
      this.schoolPackageID,
      this.startDateTime,
      this.endDateTime});

  Class.fromJson(Map<String, dynamic> map) {
    classId = map['id_classes'];
    classNo = map['ClassNo'];
    instructorId = map['id_instructor'];
    trainingClassID = map['TrainingClassID'];
    timeScheduleID = map['TimeScheduleID'];
    schoolPackageID = map['SchoolPackageID'];
    print('date: ${DateTime.parse(map['start_date_time'].toString())}');
    startDateTime =  DateTime.parse(map['start_date_time'].toString()).millisecondsSinceEpoch;
    endDateTime =  DateTime.parse(map['end_date_time'].toString()).millisecondsSinceEpoch;
    print('find');
    print(startDateTime);
  }
}
