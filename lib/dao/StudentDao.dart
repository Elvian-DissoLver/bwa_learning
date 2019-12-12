import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Class.dart';
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

  Future<List<Student>> getStudentByIdInstitution(int idInstitution) async {
    print("getStudentByIdInstitution");
    var db = await database;

    print("getStudentByIdInstitution2");

    List<Student> studentList = [];

    var res = await db.query("SELECT * FROM student where idInstitution = $idInstitution");

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

  Future<List<Student>> getStudentByPhone(String noHp, int idInstitution) async {
    print("getStudentByPhone");
    var db = await database;

    List<Student> studentList = [];

    var res = await db.query("SELECT * FROM student where noHp >= $noHp and idInstitution = $idInstitution");

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

  Future<List<Student>> getStudentByIdClass(int idClass, int idInstitution) async {
    print("getStudentByIdClass");
    var db = await database;

    List<Student> studentList = [];
    var res = await db.query("SELECT * FROM student WHERE idClass = '$idClass' and idInstitution = $idInstitution");

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

  updateStudentById(Student updatedStudent, int idStudent) async {
    print("updateStudentByIdClass");
    final db = await database;
    await db.query(
        "UPDATE student SET fullName='${updatedStudent.fullName}', email='${updatedStudent.email}', noHp='${updatedStudent.noHp}', idClass=${updatedStudent.idClass}, idInstitution=${updatedStudent.idInstitution} WHERE idStudent = $idStudent"
    );
    print('Class updated: ${updatedStudent.fullName}');
  }

}
