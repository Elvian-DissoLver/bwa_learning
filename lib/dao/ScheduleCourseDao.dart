import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/ScheduleCourse.dart';
import 'package:mysql1/mysql1.dart';

class ScheduleCourseDao {

  static final ScheduleCourseDao db = ScheduleCourseDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<ScheduleCourse>> getScheduleCourse() async {
    print("getScheduleCourse");
    var db = await database;

    List<ScheduleCourse> studentList = [];

    var res = await db.query("SELECT * FROM schedule_course");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        studentList.add(ScheduleCourse.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.startAt.compareTo(b.startAt);
        });
      });
    }
    else{
      print("Null");
    }

    return studentList;
  }

  Future<List<ScheduleCourse>> getScheduleCourseByClassId(int classId, int institutionId) async {
    print("getScheduleCourseByclassId");
    var db = await database;

    List<ScheduleCourse> studentList = [];
    var res = await db.query("SELECT * FROM schedule_course WHERE classId = '$classId'");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentList.add(ScheduleCourse.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.startAt.compareTo(b.startAt);
        });
      });
    }
    else{
      print("Null");
    }
    return studentList;
  }

  Future<List<ScheduleCourse>> getScheduleCourseByTeacherId(int teacherId) async {
    print("getScheduleCourseByTeacherId");
    var db = await database;

    List<ScheduleCourse> studentList = [];
    var res = await db.query("SELECT * FROM schedule_course WHERE teacherId = '$teacherId'");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentList.add(ScheduleCourse.fromJson(f.fields));
        studentList.sort((a, b) {
          return a.startAt.compareTo(b.startAt);
        });
      });
    }
    else{
      print("Null");
    }
    return studentList;
  }

}
