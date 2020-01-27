
import 'package:bwa_learning/models/talim/Session.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class SessionDao {

  static final SessionDao db = SessionDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Session>> getSession() async {
    print("getSession");
    var db = await database;

    List<Session> sessionList = [];

    var res = await db.query("SELECT * FROM journaltrainingsession");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        sessionList.add(Session.fromJson(f.fields));
        sessionList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }

    return sessionList;
  }

  Future<List<Session>> getSessionByClassId(int classId) async {
    print("getSessionByclassId");
    var db = await database;

    List<Session> sessionList = [];
    var res = await db.query("SELECT * FROM journaltrainingsession WHERE id_classes = '$classId'");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        sessionList.add(Session.fromJson(f.fields));
        sessionList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
      });
    }
    else{
      print("Null");
    }
    return sessionList;
  }

  Future<Session> getSessionById(int sessionId) async {
    print("getSessionById");
    var db = await database;
    var res = await db.query("SELECT * FROM journaltrainingsession WHERE sessionId = '$sessionId'");

    Session findSession;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findSession = Session.fromJson(f.fields);
      });
      return findSession;
    }
    return null;
  }

}
