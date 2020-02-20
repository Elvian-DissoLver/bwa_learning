
class TrainingClass {
  int trainingClassID;
  String name;
  int standardCredit;
  int topicID;

  TrainingClass({
    this.trainingClassID,
    this.name,
    this.standardCredit,
    this.topicID
  });

  TrainingClass.fromJson(Map<String, dynamic> map) {
    trainingClassID = map['TrainingClassID'];
    name = map['Name'];
    standardCredit = map['StandardCredit'];
    topicID = map['TopicID'];
    print('TrainingClass');
  }
}
