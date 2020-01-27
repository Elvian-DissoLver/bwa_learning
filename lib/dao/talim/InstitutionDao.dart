import 'package:bwa_learning/models/talim/Institution.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class InstitutionDao {

  static final InstitutionDao db = InstitutionDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Institution>> getInstitution() async {
    print("getInstitution");
    var db = await database;

    List<Institution> institutionList = [];

    var res = await db.query("SELECT * FROM institution");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        institutionList.add(Institution.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return institutionList;
  }

  Future<Institution> getInstitutionById(int institutionId) async {
    print("getInstitutionByinstitutionId");
    var db = await database;

    var res = await db.query("SELECT * FROM institution where institutionId = $institutionId");

    Institution institution;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        institution = Institution.fromJson(f.fields);
      });
      return institution;
    } else {
      return null;
    }
  }

}
