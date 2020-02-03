
class LinkTrainingMeetingTopic {
  int id;
  int trainingSessionID;
  int topicID;
  bool dataStatusID;

  LinkTrainingMeetingTopic({
    this.id,
    this.trainingSessionID,
    this.topicID,
    this.dataStatusID
  });

  LinkTrainingMeetingTopic.fromJson(Map<String, dynamic> map) {
    id = map['ID'];
    trainingSessionID = map['TrainingSessionID'];
    dataStatusID = getIsInFromInt(map['DataStatusID']);
    topicID = map['TopicID'];
    print('loop');
  }

  static bool getIsInFromInt(int value) {
    switch(value){
      case 1:
        return true;
      case 0:
        return false;
      default:
        return false;
    }
  }

  static int getIsInFromBool(bool value) {
    switch(value){
      case true:
        return 1;
      case false:
        return 0;
      default:
        return 0;
    }
  }
}
