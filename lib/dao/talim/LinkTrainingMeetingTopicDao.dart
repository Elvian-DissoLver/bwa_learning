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

  Future<LinkTrainingMeetingTopic> getLinkTrainingMeetingTopicById(int ltmTopicId) async {
    print("getLinkTrainingMeetingTopicById");
    var db = await database;
    var res = await db.query(
        "SELECT * FROM linktrainingmeetingtopic WHERE ID = '$ltmTopicId'");

    LinkTrainingMeetingTopic findLtmTopic;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findLtmTopic = LinkTrainingMeetingTopic.fromJson(f.fields);
      });
      return findLtmTopic;
    }
    return null;
  }

  Future addLinkTrainingMeetingTopic(LinkTrainingMeetingTopic linkTrainingMeetingTopic) async {
    print("addLinkTrainingMeetingTopic");
    final db = await database;

    await db.query(
        "INSERT INTO talim.linktrainingmeetingtopic(ID,TrainingSessionID,DataStatusID,TopicID) VALUES (${linkTrainingMeetingTopic.id},${linkTrainingMeetingTopic.trainingSessionID},${LinkTrainingMeetingTopic.getIsInFromBool(linkTrainingMeetingTopic.dataStatusID)},'${linkTrainingMeetingTopic.topicID}')");
    print('sukses post');
  }

  Future updateLinkTrainingMeetingTopic(LinkTrainingMeetingTopic linkTrainingMeetingTopic) async {
    print("updateLinkTrainingMeetingTopic");
    final db = await database;

    await db.query(
        "UPDATE linktrainingmeetingtopic SET DataStatusID=${LinkTrainingMeetingTopic.getIsInFromBool(linkTrainingMeetingTopic.dataStatusID)} WHERE ID=${linkTrainingMeetingTopic.id}");
    print('sukses update');
  }
}
