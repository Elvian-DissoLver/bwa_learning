import 'dart:math';

import 'package:bwa_learning/models/talim/SessionAbsence.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class SessionAbsenceDao {
  static final SessionAbsenceDao db = SessionAbsenceDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<SessionAbsence>> getSessionAbsence() async {
    print("getSessionAbsence");
    var db = await database;

    List<SessionAbsence> sessionAbsenceList = [];

    var res = await db.query("SELECT * FROM journalsessionabsence");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        sessionAbsenceList.add(SessionAbsence.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return sessionAbsenceList;
  }

  Future<List<SessionAbsence>> getSessionAbsenceByTrainingSessionID(
      int trainingSessionID) async {
    print("getSessionAbsenceByTrainingSessionID");
    var db = await database;

    List<SessionAbsence> sessionAbsenceList = [];
    var res = await db.query(
        "SELECT * FROM journalsessionabsence WHERE TrainingSessionID = $trainingSessionID GROUP BY PersonID ORDER BY PersonID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        sessionAbsenceList.add(SessionAbsence.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return sessionAbsenceList;
  }

  Future<List<SessionAbsence>> getSessionAbsenceByTrainingSessionIDAndDate(
      int trainingSessionID, var dateTime) async {
    print("getSessionAbsenceByTrainingSessionIDAndDate");
    var db = await database;

    List<SessionAbsence> sessionAbsenceList = [];
    var res = await db.query(
        "SELECT * FROM journalsessionabsence WHERE TrainingSessionID = '$trainingSessionID' and Date_='$dateTime' GROUP BY PersonID ORDER BY PersonID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        sessionAbsenceList.add(SessionAbsence.fromJson(f.fields));
      });
      print('success2');
    } else {
      print("Null");
    }
    return sessionAbsenceList;
  }

  Future<SessionAbsence> getSessionAbsenceByPersonIdAndDate(String personId, var date) async {
    print("getSessionAbsenceByPersonIdAndDate");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM journalsessionabsence WHERE PersonId = '$personId' AND Date_='$date'");

    SessionAbsence findSessionAbsence;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findSessionAbsence = SessionAbsence.fromJson(f.fields);
      });
      return findSessionAbsence;
    }
    return null;
  }

  Future<SessionAbsence> getSessionAbsenceById(int sessionAbsenceId) async {
    print("getSessionAbsenceById");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM journalsessionabsence WHERE sessionAbsenceId = '$sessionAbsenceId'").catchError((onError) {
          print(onError);
          return onError;
    });

    SessionAbsence findSessionAbsence;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findSessionAbsence = SessionAbsence.fromJson(f.fields);
      });
      return findSessionAbsence;
    }
    return null;
  }

  Future addSessionAbsence(SessionAbsence sessionAbsence) async {
    print("addSessionAbsence");
    final db = await database;
    var random = Random.secure();
    sessionAbsence.sessionAbsenceID = random.nextInt(999999);

    await db.query(
        "INSERT INTO talim.journalsessionabsence(ID,PersonID,TrainingSessionID,IsIn,Date_) VALUES (${sessionAbsence.sessionAbsenceID},'${sessionAbsence.studentID}',${sessionAbsence.trainingSessionID},${SessionAbsence.getIsInFromBool(sessionAbsence.isIn)},'${sessionAbsence.date}')")
    .catchError((onError){
      print('error: $onError');
      return onError;
    });
    print('sukses post');
  }

  Future updateSessionAbsence(SessionAbsence sessionAbsence) async {
    print("addSessionAbsence");
    final db = await database;

    await db.query(
        "UPDATE journalsessionabsence SET IsIn=${SessionAbsence.getIsInFromBool(sessionAbsence.isIn)} WHERE ID=${sessionAbsence.sessionAbsenceID}");
    print('sukses update');
  }
}
