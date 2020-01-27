class Session {
  int trainingSessionID;
  String name;
  int classId;
  int instructorId;

  Session({
    this.instructorId,
    this.name,
    this.classId,
    this.trainingSessionID
  });

  Session.fromJson(Map<String, dynamic> map) {
    trainingSessionID = map['TrainingSessionID'];
    name = map['Name'];
    classId = map['id_classes'];
    instructorId = map['id_instructor'];
  }
}