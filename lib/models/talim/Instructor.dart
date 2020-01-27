class Instructor {
  int instructorId;
  String name;
  String emailAddress;
  int phone;

  Instructor({
    this.instructorId,
    this.name,
    this.emailAddress,
    this.phone
  });

  Instructor.fromJson(Map<String, dynamic> map) {
    this.instructorId = map['id_instructor'];
    name = map['name'];
    emailAddress = map['email_address'];
    phone = map['phone'];
  }
}