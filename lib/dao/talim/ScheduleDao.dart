import 'package:bwa_learning/models/talim/Schedule.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class ScheduleDao {
  static final ScheduleDao db = ScheduleDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Schedule>> getSchedule() async {
    print("getSchedule");
    var db = await database;

    List<Schedule> scheduleList = [];

    var res = await db.query("SELECT * FROM schedule");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        scheduleList.add(Schedule.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return scheduleList;
  }

  Future<Schedule> getScheduleById(int scheduleId) async {
    print("getScheduleById");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM schedule WHERE ScheduleID = '$scheduleId'");

    Schedule findSchedule;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findSchedule = Schedule.fromJson(f.fields);
      });
      return findSchedule;
    }
    return null;
  }

  Future<List<Schedule>> getScheduleByTimeScheduleId(int timeScheduleId) async {
    print("getScheduleByTimeScheduleId");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM schedule WHERE TimeScheduleID = '$timeScheduleId'");

    List<Schedule> schedules = [];

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        schedules.add(Schedule.fromJson(f.fields));
      });
      return schedules;
    }
    return null;
  }

  Future<List<Schedule>> getScheduleByCompanyId(int companyId) async {
    print("getScheduleByCompanyId");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM schedule WHERE Company_id = $companyId");

    List<Schedule> schedules = [];

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        schedules.add(Schedule.fromJson(f.fields));
      });
      return schedules;
    }
    return null;
  }

}
