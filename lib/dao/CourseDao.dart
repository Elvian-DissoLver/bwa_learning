import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Course.dart';
import 'package:mysql1/mysql1.dart';

class CourseDao {

  static final CourseDao db = CourseDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Course>> getCourse() async {
    print("getCourse");
    var db = await database;

    List<Course> courseList = [];

    var res = await db.query("SELECT * FROM course");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        courseList.add(Course.fromJson(f.fields));
        courseList.sort((a, b) {
          return a.courseName.compareTo(b.courseName);
        });
      });
    }
    else{
      print("Null");
    }

    return courseList;
  }

  Future<List<Course>> getCourseByInstitutionId(int institutionId) async {
    print("getCourseByinstitutionId");
    var db = await database;

    List<Course> courseList = [];

    var res = await db.query("SELECT * FROM course where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        courseList.add(Course.fromJson(f.fields));
        courseList.sort((a, b) {
          return a.level.compareTo(b.level);
        });
      });
    }
    else{
      print("Null");
    }

    return courseList;
  }

}
