import 'dart:async';
import 'package:bwa_learning/dao/talim/LinkTrainingMeetingTopicDao.dart';
import 'package:bwa_learning/models/talim/LinkTrainingMeetingTopic.dart';
import 'package:scoped_model/scoped_model.dart';

mixin LinkTrainingMeetingTopicModel on Model {
  List<LinkTrainingMeetingTopic> _linkTrainingMeetingTopics = [];
  List<LinkTrainingMeetingTopic> _foundedLinkTrainingMeetingTopic = [];
  LinkTrainingMeetingTopic _linkTrainingMeetingTopic;
  bool _isLoading = false;

  List<LinkTrainingMeetingTopic> get linkTrainingMeetingTopics {
    return List.from(_linkTrainingMeetingTopics);
  }

  List<LinkTrainingMeetingTopic> get foundedLinkTrainingMeetingTopic {
    return List.from(_foundedLinkTrainingMeetingTopic);
  }

  bool get isLoading {
    return _isLoading;
  }

  LinkTrainingMeetingTopic get currentLinkTrainingMeetingTopic {
    return _linkTrainingMeetingTopic;
  }

  void setCurrentLinkTrainingMeetingTopic(LinkTrainingMeetingTopic linkTrainingMeetingTopic) {
    _linkTrainingMeetingTopic = linkTrainingMeetingTopic;
  }

  Future<bool> fetchLinkTrainingMeetingTopicByTrainingSessionId(int trainingSessionID) async {
    _isLoading = true;
    notifyListeners();

    _linkTrainingMeetingTopics = [];

    print('fetch linkTrainingMeetingTopics by TrainingSessionId');

    try {
      _linkTrainingMeetingTopics = await LinkTrainingMeetingTopicDao.db.getLinkTrainingMeetingTopicByTrainingSessionID(trainingSessionID);

      if(_linkTrainingMeetingTopics.length > 0){
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }


    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addLinkTrainingMeetingTopic(List<LinkTrainingMeetingTopic> linkTrainingMeetingTopics) async {
    _isLoading = true;
    notifyListeners();
    print('add linkTrainingMeetingTopic');

    try {
      for(LinkTrainingMeetingTopic linkTrainingMeetingTopic in linkTrainingMeetingTopics  ){
        await LinkTrainingMeetingTopicDao.db.addLinkTrainingMeetingTopic(linkTrainingMeetingTopic);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateLinkTrainingMeetingTopic(List<LinkTrainingMeetingTopic> linkTrainingMeetingTopics) async {
    _isLoading = true;
    notifyListeners();
    print('add linkTrainingMeetingTopic');

    try {
      for(LinkTrainingMeetingTopic linkTrainingMeetingTopic in linkTrainingMeetingTopics  ){
        await LinkTrainingMeetingTopicDao.db.updateLinkTrainingMeetingTopic(linkTrainingMeetingTopic);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
