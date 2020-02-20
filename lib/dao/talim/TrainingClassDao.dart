import 'package:bwa_learning/models/talim/TrainingClass.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class TrainingClassDao {
  static final TrainingClassDao db = TrainingClassDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<TrainingClass>> getTrainingClass() async {
    print("getTrainingClass");
    var db = await database;

    List<TrainingClass> trainingClassList = [];

    var res = await db.query("SELECT * FROM trainingclass");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        trainingClassList.add(TrainingClass.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return trainingClassList;
  }

  Future<List<TrainingClass>> getTrainingClassByCompanyID(
      int companyID) async {
    print("getTrainingClassByCompanyID");
    var db = await database;

    List<TrainingClass> trainingClassList = [];
    var res = await db.query(
        "SELECT * FROM trainingclass WHERE Company_id = $companyID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        trainingClassList.add(TrainingClass.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return trainingClassList;
  }
}
