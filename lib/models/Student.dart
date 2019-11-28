
class Student {
  String idStudent;
  String fullName;
  String email;
  String noHp;
  String idKelas;
  String idInstitution;
  List<String> idParent;

  Student({
    this.idStudent,
    this.fullName,
    this.email,
    this.noHp,
    this.idKelas,
    this.idInstitution,
    this.idParent
  });

  Student.fromJson(Map<String, dynamic> map, String id) {
    this.idStudent = id;
    fullName = map['fullName'];
    email = map['email'];
    noHp = map['map'];
    idKelas = map['idKelas'];
    idInstitution = map['idInstitution'];
  }
}