
class Student {
  int idStudent;
  String fullName;
  String email;
  String noHp;
  int idClass;
  int idInstitution;
  List<String> idParent;


  Student({
    this.idStudent,
    this.fullName,
    this.email,
    this.noHp,
    this.idClass,
    this.idInstitution,
    this.idParent
  });

  Student.fromJson(Map<String, dynamic> map) {
    this.idStudent = map['idStudent'];
    fullName = map['fullName'];
    email = map['email'];
    noHp = map['noHp'];
    idClass = map['idClass'];
    idInstitution = map['idInstitution'];
  }
}