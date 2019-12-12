import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Class.dart';
import 'package:bwa_learning/models/Teacher.dart';
import 'package:bwa_learning/models/Teacher.dart';
import 'package:mysql1/mysql1.dart';

class TeacherDao {

  static final TeacherDao db = TeacherDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Teacher>> getTeacher() async {
    print("getTeacher");
    var db = await database;

    List<Teacher> teacherList = [];

    var res = await db.query("SELECT * FROM teacher");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        teacherList.add(Teacher.fromJson(f.fields));
        teacherList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return teacherList;
  }

  Future<List<Teacher>> getTeacherByIdInstitution(int idInstitution) async {
    print("getTeacherByIdInstitution");
    var db = await database;

    List<Teacher> teacherList = [];

    var res = await db.query("SELECT * FROM teacher where idInstitution = $idInstitution");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        teacherList.add(Teacher.fromJson(f.fields));
        teacherList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return teacherList;
  }

  Future<List<Teacher>> getTeacherByPhone(String noHp, int idInstitution) async {
    print("getTeacherByPhone");
    var db = await database;

    List<Teacher> teacherList = [];

    var res = await db.query("SELECT * FROM teacher where noHp >= $noHp and idInstitution = $idInstitution");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        teacherList.add(Teacher.fromJson(f.fields));
        teacherList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }

    return teacherList;
  }

  Future<List<Teacher>> getTeacherByIdClass(int idClass, int idInstitution) async {
    print("getTeacherByIdClass");
    var db = await database;

    List<Teacher> teacherList = [];
    var res = await db.query("SELECT * FROM teacher WHERE idClass = '$idClass' and idInstitution = $idInstitution");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        teacherList.add(Teacher.fromJson(f.fields));
        teacherList.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });
    }
    else{
      print("Null");
    }
    return teacherList;
  }

}
