import 'dart:async';

import 'package:bwa_learning/dao/talim/SessionAbsenceDao.dart';
import 'package:bwa_learning/models/talim/SessionAbsence.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

mixin SessionAbsenceModel on Model {
  List<SessionAbsence> _sessionAbsences = [];
  List<SessionAbsence> _foundedSessionAbsence = [];
  SessionAbsence _sessionAbsence;
  bool _isLoading = false;

  List<SessionAbsence> get sessionAbsences {
    return List.from(_sessionAbsences);
  }

  List<SessionAbsence> get foundedSessionAbsence {
    return List.from(_foundedSessionAbsence);
  }

  bool get isLoading {
    return _isLoading;
  }

  SessionAbsence get currentSessionAbsence {
    return _sessionAbsence;
  }

  void setCurrentSessionAbsence(SessionAbsence sessionAbsence) {
    _sessionAbsence = sessionAbsence;
  }

  Future<bool> fetchSessionAbsenceByTrainingSessionId(int trainingSessionID) async {
    _isLoading = true;
    notifyListeners();

    _sessionAbsences = [];

    print('fetch sessionAbsences by TrainingSessionId');

    try {
      _sessionAbsences = await SessionAbsenceDao.db.getSessionAbsenceByTrainingSessionID(trainingSessionID);

      if(_sessionAbsences.length > 0){
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

  Future<bool> fetchSessionAbsenceByTrainingSessionIdAndDate(int trainingSessionID, var dateTime) async {
    _isLoading = true;
    notifyListeners();

    _sessionAbsences = [];

    print('fetch sessionAbsences by TrainingSessionIdAndDate');

    try {
      _sessionAbsences = await SessionAbsenceDao.db.getSessionAbsenceByTrainingSessionIDAndDate(trainingSessionID, dateTime);

      if(_sessionAbsences.length > 0){
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

  Future<bool> fetchSessionAbsenceByPersonIdAndDate(String personId, var date) async {
    _isLoading = true;
    notifyListeners();

    print('fetch sessionAbsence by personId and date');

    try {
      await SessionAbsenceDao.db.getSessionAbsenceByPersonIdAndDate(personId, date).then((onValue) {
        _sessionAbsence = onValue;
      });
      if(_sessionAbsence!=null) {
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

  Future<bool> fetchSessionAbsenceById(int sessionAbsenceId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch sessionAbsence by id');

    try {
      await SessionAbsenceDao.db.getSessionAbsenceById(sessionAbsenceId).then((onValue) {
        _sessionAbsence = onValue;
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

  Future<bool> addSessionAbsence(List<SessionAbsence> sessionAbsences) async {
    _isLoading = true;
    notifyListeners();
    print('add sessionAbsence');

    try {
      for(SessionAbsence sessionAbsence in sessionAbsences  ){
        print('Absence isIn: ${sessionAbsence.isIn}');
        await SessionAbsenceDao.db.addSessionAbsence(sessionAbsence);
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

  Future<bool> updateSessionAbsence(List<SessionAbsence> sessionAbsences) async {
    _isLoading = true;
    notifyListeners();
    print('add sessionAbsence');

    try {
      for(SessionAbsence sessionAbsence in sessionAbsences  ){
        print('Absence isIn: ${sessionAbsence.isIn}');
        await SessionAbsenceDao.db.updateSessionAbsence(sessionAbsence);
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
