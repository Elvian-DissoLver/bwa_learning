import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Student.dart';
import 'package:mysql1/mysql1.dart';

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

  Future<List<Student>> getStudentByinstitutionId(int institutionId) async {
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

  Future<List<Student>> getStudentByclassId(int classId, int institutionId) async {
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
