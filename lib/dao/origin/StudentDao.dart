import 'package:bwa_learning/models/origin/Student.dart';
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

    var res = await db.query("SELECT * FROM student");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        studentList.add(Student.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return studentList;
  }

  Future<Student> getStudentByEmail(String email, int institutionId) async {
    print("getStudentByEmail");
    var db = await database;
    var res = await db.query("SELECT * FROM student WHERE email = '$email' and institutionId='$institutionId'");

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

  Future<List<Student>> getStudentByInstitutionId(int institutionId) async {
    print("getStudentByinstitutionId");
    var db = await database;

    print("getStudentByinstitutionId2");

    List<Student> studentList = [];

    var res = await db.query("SELECT * FROM student where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        studentList.add(Student.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return studentList;
  }

  Future<List<Student>> getStudentByPhone(String noHp, int institutionId) async {
    print("getStudentByPhone");
    var db = await database;

    List<Student> studentList = [];

    var res = await db.query("SELECT * FROM student where noHp >= $noHp and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentList.add(Student.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return studentList;
  }

  Future<List<Student>> getStudentByClassId(int classId, int institutionId) async {
    print("getStudentByclassId");
    var db = await database;

    List<Student> studentList = [];
    var res = await db.query("SELECT * FROM student WHERE classId = '$classId' and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentList.add(Student.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }
    return studentList;
  }

  updateStudentById(Student updatedStudent, int studentId) async {
    print("updateStudentByclassId");
    final db = await database;
    await db.query(
        "UPDATE student SET fullName='${updatedStudent.fullName}', email='${updatedStudent.email}', noHp='${updatedStudent.noHp}', classId=${updatedStudent.classId}, institutionId=${updatedStudent.institutionId} WHERE studentId = $studentId"
    );
    print('Class updated: ${updatedStudent.fullName}');
  }

}
