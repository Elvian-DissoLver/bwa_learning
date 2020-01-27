
import 'package:bwa_learning/models/talim/Instructor.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class InstructorDao {

  static final InstructorDao db = InstructorDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Instructor>> getInstructor() async {
    print("getInstructor");
    var db = await database;

    List<Instructor> instructorList = [];

    var res = await db.query("SELECT * FROM instructor");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        instructorList.add(Instructor.fromJson(f.fields));
        instructorList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }

    return instructorList;
  }

  Future<List<Instructor>> getInstructorByInstitutionId(int institutionId) async {
    print("getInstructorByinstitutionId");
    var db = await database;

    List<Instructor> instructorList = [];

    var res = await db.query("SELECT * FROM instructor where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        instructorList.add(Instructor.fromJson(f.fields));
        instructorList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }

    return instructorList;
  }

  Future<List<Instructor>> getInstructorByPhone(String noHp, int institutionId) async {
    print("getInstructorByPhone");
    var db = await database;

    List<Instructor> instructorList = [];

    var res = await db.query("SELECT * FROM instructor where noHp >= $noHp and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        instructorList.add(Instructor.fromJson(f.fields));
        instructorList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }

    return instructorList;
  }

  Future<List<Instructor>> getInstructorByClassId(int classId, int institutionId) async {
    print("getInstructorByclassId");
    var db = await database;

    List<Instructor> instructorList = [];
    var res = await db.query("SELECT * FROM instructor WHERE classId = '$classId' and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        instructorList.add(Instructor.fromJson(f.fields));
        instructorList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }
    return instructorList;
  }

  Future<Instructor> getInstructorById(int instructorId) async {
    print("getInstructorById");
    var db = await database;
    var res = await db.query("SELECT * FROM instructor WHERE instructorId = '$instructorId'");

    Instructor findInstructor;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findInstructor = Instructor.fromJson(f.fields);
      });
      return findInstructor;
    }
    return null;
  }

  Future<Instructor> getInstructorByEmail(String email) async {
    print("getInstructorByEmail");
    var db = await database;
    var res = await db.query("SELECT * FROM instructors WHERE email_address = '$email'");

    Instructor findInstructor;

    if (res.length > 0) {

      res.forEach((f) {
        print(f);
        findInstructor = Instructor.fromJson(f.fields);
      });

      return findInstructor;
    }
    return null;
  }

}
