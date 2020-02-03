
class Topic {
  int topicID;
  String name;
  String keywords;
  int parentTopicID;
  int companyID;

  Topic({
    this.name,
    this.keywords,
    this.topicID,
    this.parentTopicID,
    this.companyID
  });

  Topic.fromJson(Map<String, dynamic> map) {
    topicID = map['TopicID'];
    name = map['Name_en_us'];
    keywords = map['Keywords'];
    parentTopicID = map['Parent_TopicID'];
    companyID = map['Company_id'];
  }
}
