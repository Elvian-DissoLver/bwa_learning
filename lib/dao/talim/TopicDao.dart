import 'package:bwa_learning/models/talim/Topic.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class TopicDao {
  static final TopicDao db = TopicDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Topic>> getTopic() async {
    print("getTopic");
    var db = await database;

    List<Topic> topicList = [];

    var res = await db.query("SELECT * FROM topic");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        topicList.add(Topic.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return topicList;
  }

  Future<List<Topic>> getTopicByCompanyIDAndKeyword(
      int companyID, String keyword) async {
    print("getTopicByCompanyIDAndKeyword");
    var db = await database;

    List<Topic> topicList = [];
    var res = await db.query(
        "SELECT * FROM topic WHERE Company_id = $companyID AND Keywords=$keyword");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        topicList.add(Topic.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return topicList;
  }
}
