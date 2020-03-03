import 'package:bwa_learning/models/talim/StudentProgress.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class StudentProgressDao {
  static final StudentProgressDao db = StudentProgressDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<StudentProgress>> getStudentProgress() async {
    print("getStudentProgress");
    var db = await database;

    List<StudentProgress> studentProgressList = [];

    var res = await db.query("SELECT * FROM journalstudentprogress");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        studentProgressList.add(StudentProgress.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return studentProgressList;
  }

  Future<List<StudentProgress>> getStudentProgressByTopicID(
      int topicID) async {
    print("getStudentProgressByTopicID");
    var db = await database;

    List<StudentProgress> studentProgressList = [];
    var res = await db.query(
        "SELECT * FROM journalstudentprogress WHERE TopicID = $topicID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentProgressList.add(StudentProgress.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return studentProgressList;
  }

  Future<List<StudentProgress>> getStudentProgressByClassIDAndTopicID(
      int classID, int topicID) async {
    print("getStudentProgressByClassIDAndTopicID");
    var db = await database;

    List<StudentProgress> studentProgressList = [];
    var res = await db.query(
        "SELECT * FROM journalstudentprogress WHERE id_classes = $classID AND TopicID=$topicID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        studentProgressList.add(StudentProgress.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return studentProgressList;
  }

  Future<StudentProgress> getStudentProgressByClassIdTopicIDAndStudentId(
      int classID, int topicID, var studentId) async {
    print("getStudentProgressByClassIdTopicIDAndStudentId");
    var db = await database;

    StudentProgress findStudentProgress;
    var res = await db.query(
        "SELECT * FROM journalstudentprogress WHERE id_classes = $classID AND TopicID=$topicID AND id_student=$studentId");

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findStudentProgress = StudentProgress.fromJson(f.fields);
      });
      return findStudentProgress;
    }
    return null;
  }

  Future<StudentProgress> getStudentProgressById(int ltmTopicId) async {
    print("getStudentProgressById");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM journalstudentprogress WHERE ID = '$ltmTopicId'");

    StudentProgress findLtmTopic;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findLtmTopic = StudentProgress.fromJson(f.fields);
      });
      return findLtmTopic;
    }
    return null;
  }

  Future updateStudentProgress(StudentProgress studentProgress) async {
    print("updateStudentProgress");
    final db = await database;

    await db.query(
        "UPDATE journalstudentprogress SET QuantitativeScore=${studentProgress.quantitativeScore} WHERE ID=${studentProgress.studentProgressID}");
    print('sukses update studentProgress');
  }
}
