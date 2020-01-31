import 'dart:async';

import 'package:bwa_learning/dao/talim/SessionDao.dart';
import 'package:bwa_learning/models/talim/Session.dart';
import 'package:scoped_model/scoped_model.dart';

mixin SessionModel on Model {
  List<Session> _sessions = [];
  List<Session> _foundedSession = [];
  Session _session;
  bool _isLoading = false;

  List<Session> get sessions {
    return List.from(_sessions);
  }

  List<Session> get foundedSession {
    return List.from(_foundedSession);
  }

  bool get isLoading {
    return _isLoading;
  }

  Session get currentSession {
    return _session;
  }

  void setCurrentSession(Session session) {
    _session = session;
  }

  Future<bool> fetchSessionByClassId(int classId) async {
    _isLoading = true;
    notifyListeners();

    _sessions = [];

    print('fetch sessions by classId');

    try {
      _sessions = await SessionDao.db.getSessionByClassId(classId);

      if(_sessions.length > 0){
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

  Future<bool> fetchSessionById(int sessionId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch session by id');

    try {
      await SessionDao.db.getSessionById(sessionId).then((onValue) {
        _session = onValue;
      });

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
