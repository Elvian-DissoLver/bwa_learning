import 'package:bwa_learning/models/talim/Student.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class StudentDao {

  static final StudentDao db = StudentDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Student>> getStudent() async {
    print("getStudent");
    var db = await database;

    List<Student> studentList = [];

    var res = await db.query("SELECT * FROM journalsessionabsence");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        studentList.add(Student.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return studentList;
  }

  Future<Student> getStudentById(var studentId) async {
    print("getStudentByStudentId");
    var db = await database;
    var res = await db.query("SELECT * FROM students WHERE StudentID = '$studentId'");

    Student findStudent;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findStudent = Student.fromJson(f.fields);
      });
      return findStudent;
    }
    return null;
  }

  Future<List<Student>> getStudentByInstitutionID(int institutionId) async {
    print("getStudentByInstitutionID");
    var db = await database;
    var res = await db.query("SELECT * FROM students WHERE InstitutionID = '$institutionId'");

    List<Student> findStudent = [];

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findStudent.add(Student.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }
    return findStudent;
  }

  Future<Student> getStudentByEmail(String email) async {
    print("getStudentByEmail");
    var db = await database;
    var res = await db.query("SELECT * FROM students WHERE email = '$email'");

    Student findStudent;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findStudent = Student.fromJson(f.fields);
      });
      return findStudent;
    }
    return null;
  }

}
