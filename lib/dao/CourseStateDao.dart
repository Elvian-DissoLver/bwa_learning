import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/CourseState.dart';
import 'package:mysql1/mysql1.dart';

class CourseStateDao {

  static final CourseStateDao db = CourseStateDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<CourseState>> getCourseState() async {
    print("getCourseState");
    var db = await database;

    List<CourseState> courseStateList = [];

    var res = await db.query("SELECT * FROM course_state");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        courseStateList.add(CourseState.fromJson(f.fields));
        courseStateList.sort((a, b) {
          return a.startAt.compareTo(b.startAt);
        });
      });
    }
    else{
      print("Null");
    }

    return courseStateList;
  }

  Future<List<CourseState>> getCourseStateByInstitutionId(int institutionId) async {
    print("getCourseStateByinstitutionId");
    var db = await database;

    List<CourseState> courseStateList = [];

    var res = await db.query("SELECT * FROM course_state where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        courseStateList.add(CourseState.fromJson(f.fields));
        courseStateList.sort((a, b) {
          return a.startAt.compareTo(b.startAt);
        });
      });
    }
    else{
      print("Null");
    }

    return courseStateList;
  }

  Future<CourseState> getCourseStateByCourseIdAndClassID(int courseId, int classId) async {
    print("getCourseStateByCourseIdAndClassID");
    var db = await database;
    var res = await db.query("SELECT * FROM course_state WHERE courseId = '$courseId' AND classId = '$classId'");

    CourseState findCourseState;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findCourseState = CourseState.fromJson(f.fields);
      });
      return findCourseState;
    }
    return null;
  }

}
