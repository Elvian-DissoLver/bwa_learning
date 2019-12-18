import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Class.dart';
import 'package:mysql1/mysql1.dart';

class ClassDao {

  static final ClassDao db = ClassDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Class>> getClass() async {
    print("getClass");
    var db = await database;

    List<Class> classList = [];

    var res = await db.query("SELECT * FROM class");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        classList.add(Class.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return classList;
  }

  Future<List<Class>> getClassByInstitutionId(int institutionId) async {
    print("getClassByinstitutionId");
    var db = await database;

    List<Class> classList = [];

    var res = await db.query("SELECT * FROM class where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        classList.add(Class.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return classList;
  }

  Future<Class> getClassByName(String className, int institutionId) async {
    print("getClassByName");
    var db = await database;
    var res = await db.query("SELECT * FROM class WHERE className = '$className' and institutionId = $institutionId");

    Class findClass;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findClass = Class.fromJson(f.fields);
      });
      return findClass;
    }
    return null;
  }

  Future<Class> getClassById(int classId, int institutionId) async {
    print("getClassById");
    var db = await database;
    var res = await db.query("SELECT * FROM class WHERE classId = '$classId' and institutionId = $institutionId");

    Class findClass;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findClass = Class.fromJson(f.fields);
      });
      return findClass;
    }
    return null;
  }

  Future addClass(Class newClass) async {
    print("addClass");
    final db = await database;
    await db.query("INSERT INTO class VALUES (${newClass.classId},'${newClass.className}','${newClass.level}','${newClass.teacherClass}','${newClass.institutionId}')");

  }

  updateClassById(Class updatedClass, int classId) async {
    print("updateClass");
    final db = await database;
    await db.query("UPDATE class SET ${updatedClass.toMap()} WHERE idClass = $classId ");
    print('Class updated: ${updatedClass.className}');
  }

}
