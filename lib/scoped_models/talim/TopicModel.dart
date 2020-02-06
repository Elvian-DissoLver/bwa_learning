import 'dart:async';
import 'package:bwa_learning/dao/talim/TopicDao.dart';
import 'package:bwa_learning/models/talim/Topic.dart';
import 'package:scoped_model/scoped_model.dart';

mixin TopicModel on Model {
  List<Topic> _topics = [];
  List<Topic> _foundedTopic = [];
  Topic _topic;
  bool _isLoading = false;

  List<Topic> get topics {
    return List.from(_topics);
  }

  List<Topic> get foundedTopic {
    return List.from(_foundedTopic);
  }

  bool get isLoading {
    return _isLoading;
  }

  Topic get currentTopic {
    return _topic;
  }

  void setCurrentTopic(Topic topic) {
    _topic = topic;
  }

  void setLoading2(bool loading){
    _isLoading = loading;
  }

  Future<bool> fetchTopicByCompanyIdAndKeyword(
      int companyID, String keyword) async {
    _isLoading = true;
    notifyListeners();

    _topics = [];

    print('fetch topics by CompanyId and keyword');

    _topics =
        await TopicDao.db.getTopicByCompanyIDAndKeyword(companyID, keyword);

    if (_topics.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
