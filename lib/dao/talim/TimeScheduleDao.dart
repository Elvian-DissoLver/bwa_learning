import 'package:bwa_learning/models/talim/TimeSchedule.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class TimeScheduleDao {
  static final TimeScheduleDao db = TimeScheduleDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<TimeSchedule>> getTimeSchedule() async {
    print("getTimeSchedule");
    var db = await database;

    List<TimeSchedule> timeScheduleList = [];

    var res = await db.query("SELECT * FROM timeschedule");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        timeScheduleList.add(TimeSchedule.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return timeScheduleList;
  }

  Future<TimeSchedule> getTimeScheduleById(int timeScheduleId) async {
    print("getTimeScheduleById");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM timeschedule WHERE TimeScheduleID = '$timeScheduleId'");

    TimeSchedule findTimeSchedule;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findTimeSchedule = TimeSchedule.fromJson(f.fields);
      });
      return findTimeSchedule;
    }
    return null;
  }

  Future<List<TimeSchedule>> getTimeScheduleByCompanyID(
      int companyID) async {
    print("TimeScheduleByCompanyID");
    var db = await database;

    List<TimeSchedule> timeScheduleList = [];
    var res = await db.query(
        "SELECT * FROM timeschedule WHERE Company_id = $companyID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        timeScheduleList.add(TimeSchedule.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return timeScheduleList;
  }

}
