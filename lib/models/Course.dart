class Course {
  int idCourse;
  String courseName;
  int idTeacher;
  int idInstitution;

  Course({
    this.idCourse,
    this.courseName,
    this.idTeacher
  });

  Course.fromJson(Map<String, dynamic> map) {
    idCourse = map['idCourse'];
    courseName = map['courseName'];
    idTeacher = map['idTeacher'];
    idInstitution = map['idInstitution'];
  }
}