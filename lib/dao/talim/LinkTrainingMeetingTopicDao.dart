import 'dart:math';

import 'package:bwa_learning/models/talim/LinkTrainingMeetingTopic.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class LinkTrainingMeetingTopicDao {
  static final LinkTrainingMeetingTopicDao db = LinkTrainingMeetingTopicDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<LinkTrainingMeetingTopic>> getLinkTrainingMeetingTopic() async {
    print("getLinkTrainingMeetingTopic");
    var db = await database;

    List<LinkTrainingMeetingTopic> linkTrainingMeetingTopicList = [];

    var res = await db.query("SELECT * FROM linktrainingmeetingtopic");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        linkTrainingMeetingTopicList.add(LinkTrainingMeetingTopic.fromJson(f.fields));
      });
    } else {
      print("Null");
    }

    return linkTrainingMeetingTopicList;
  }

  Future<List<LinkTrainingMeetingTopic>> getLinkTrainingMeetingTopicByTrainingSessionID(
      int trainingSessionID) async {
    print("getLinkTrainingMeetingTopicByTrainingSessionID");
    var db = await database;

    List<LinkTrainingMeetingTopic> linkTrainingMeetingTopicList = [];
    var res = await db.query(
        "SELECT * FROM linktrainingmeetingtopic WHERE TrainingSessionID = $trainingSessionID");

    if (res.length > 0) {
      res.forEach((f) {
        print(f.fields);
        linkTrainingMeetingTopicList.add(LinkTrainingMeetingTopic.fromJson(f.fields));
      });
    } else {
      print("Null");
    }
    return linkTrainingMeetingTopicList;
  }

  Future addLinkTrainingMeetingTopic(LinkTrainingMeetingTopic linkTrainingMeetingTopic) async {
    print("addLinkTrainingMeetingTopic");
    final db = await database;
    var random = Random.secure();
    linkTrainingMeetingTopic.id = random.nextInt(999999);

    await db.query(
        "INSERT INTO talim.linktrainingmeetingtopic(ID,PersonID,TrainingSessionID,IsIn,Date_) VALUES (${linkTrainingMeetingTopic.id},${linkTrainingMeetingTopic.trainingSessionID},${LinkTrainingMeetingTopic.getIsInFromBool(linkTrainingMeetingTopic.dataStatusID)},'${linkTrainingMeetingTopic.topicID}')")
    .catchError((onError){
      print('error: $onError');
      return onError;
    });
    print('sukses post');
  }

  Future updateLinkTrainingMeetingTopic(LinkTrainingMeetingTopic linkTrainingMeetingTopic) async {
    print("addLinkTrainingMeetingTopic");
    final db = await database;

    await db.query(
        "UPDATE linktrainingmeetingtopic SET IsIn=${LinkTrainingMeetingTopic.getIsInFromBool(linkTrainingMeetingTopic.dataStatusID)} WHERE ID=${linkTrainingMeetingTopic.id}");
    print('sukses update');
  }
}
