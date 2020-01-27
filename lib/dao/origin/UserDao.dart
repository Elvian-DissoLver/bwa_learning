import 'package:bwa_learning/models/origin/User.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class UserDao {

  static final UserDao db = UserDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<User>> getUser() async {
    print("getUser");
    var db = await database;

    List<User> userList = [];

    var res = await db.query("SELECT * FROM user");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        userList.add(User.fromJson(f.fields));
        userList.sort((a, b) {
          return a.userName.compareTo(b.userName);
        });
      });
    }
    else{
      print("Null");
    }

    return userList;
  }

  Future<User> getUserByEmail(String email) async {
    print("getUserByEmail");
    var db = await database;
    var res = await db.query("SELECT * FROM user WHERE email = '$email'");

    User findUser;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findUser = User.fromJson(f.fields);
      });
      return findUser;
    }
    return null;
  }

  Future<List<User>> getUserByInstitutionId(int institutionId) async {
    print("getUserByinstitutionId");
    var db = await database;

    print("getUserByinstitutionId2");

    List<User> userList = [];

    var res = await db.query("SELECT * FROM user where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        userList.add(User.fromJson(f.fields));
        userList.sort((a, b) {
          return a.userName.compareTo(b.userName);
        });
      });
    }
    else{
      print("Null");
    }

    return userList;
  }

  Future<List<User>> getUserByPhone(String noHp, int institutionId) async {
    print("getUserByPhone");
    var db = await database;

    List<User> userList = [];

    var res = await db.query("SELECT * FROM user where noHp >= $noHp and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        userList.add(User.fromJson(f.fields));
        userList.sort((a, b) {
          return a.userName.compareTo(b.userName);
        });
      });
    }
    else{
      print("Null");
    }

    return userList;
  }

  Future<List<User>> getUserByClassId(int classId, int institutionId) async {
    print("getUserByclassId");
    var db = await database;

    List<User> userList = [];
    var res = await db.query("SELECT * FROM user WHERE classId = '$classId' and institutionId = $institutionId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        userList.add(User.fromJson(f.fields));
        userList.sort((a, b) {
          return a.userName.compareTo(b.userName);
        });
      });
    }
    else{
      print("Null");
    }
    return userList;
  }

}
