
class Student {
  int studentId;
  String fullName;
  String email;
  String noHp;
  int classId;
  int institutionId;
  List<String> parentId;


  Student({
    this.studentId,
    this.fullName,
    this.email,
    this.noHp,
    this.classId,
    this.institutionId,
    this.parentId
  });

  Student.fromJson(Map<String, dynamic> map) {
    this.studentId = map['studentId'];
    fullName = map['fullName'];
    email = map['email'];
    noHp = map['noHp'];
    classId = map['classId'];
    institutionId = map['institutionId'];
  }
}