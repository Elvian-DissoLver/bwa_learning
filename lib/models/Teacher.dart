class Teacher {
  int idTeacher;
  String fullName;
  String email;
  String noHp;
  int idClass;
  int idInstitution;

  Teacher({
    this.idTeacher,
    this.fullName,
    this.email,
    this.noHp,
    this.idClass,
    this.idInstitution
  });

  Teacher.fromJson(Map<String, dynamic> map) {
    this.idTeacher = map['idTeacher'];
    fullName = map['fullName'];
    email = map['email'];
    noHp = map['noHp'];
    idClass = map['idClass'];
    idInstitution = map['idInstitution'];
  }
}