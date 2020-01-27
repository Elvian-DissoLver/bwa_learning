class Teacher {
  int teacherId;
  String fullName;
  String email;
  String noHp;
  int classId;
  int institutionId;

  Teacher({
    this.teacherId,
    this.fullName,
    this.email,
    this.noHp,
    this.classId,
    this.institutionId
  });

  Teacher.fromJson(Map<String, dynamic> map) {
    this.teacherId = map['teacherId'];
    fullName = map['fullName'];
    email = map['email'];
    noHp = map['noHp'];
    classId = map['classId'];
    institutionId = map['institutionId'];
  }
}