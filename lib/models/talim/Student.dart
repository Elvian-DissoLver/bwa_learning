class Student {
  int id;
  String studentID;
  String fullName;
  String emailAddress;
  int institutionID;

  Student({
    this.id,
    this.studentID,
    this.fullName,
    this.emailAddress,
    this.institutionID
  });

  Student.fromJson(Map<String, dynamic> map) {
    id = map['id_student'];
    studentID = map['StudentID'];
    fullName = map['full_name'];
    emailAddress = map['email_address'];
    institutionID = map['InstitutionID'];
  }
}