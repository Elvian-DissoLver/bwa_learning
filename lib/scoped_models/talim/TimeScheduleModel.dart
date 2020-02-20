import 'dart:async';
import 'package:bwa_learning/dao/talim/TimeScheduleDao.dart';
import 'package:bwa_learning/models/talim/TimeSchedule.dart';
import 'package:scoped_model/scoped_model.dart';

mixin TimeScheduleModel on Model {
  List<TimeSchedule> _timeSchedules = [];
  List<TimeSchedule> _foundedTimeSchedule = [];
  TimeSchedule _timeSchedule;
  bool _isLoading = false;

  List<TimeSchedule> get timeSchedules {
    return List.from(_timeSchedules);
  }

  List<TimeSchedule> get foundedTimeSchedule {
    return List.from(_foundedTimeSchedule);
  }

  bool get isLoading {
    return _isLoading;
  }

  TimeSchedule get currentTimeSchedule {
    return _timeSchedule;
  }

  void setCurrentTimeSchedule(
      TimeSchedule timeSchedule) {
    _timeSchedule = timeSchedule;
  }

  void setLoading(bool load){
    _isLoading = load;
  }

  Future<bool> findTimeScheduleById(int ltmTopicId) async {
    _isLoading = true;
    notifyListeners();

    print('find TimeSchedule by id');

    _timeSchedule = await TimeScheduleDao.db
        .getTimeScheduleById(ltmTopicId);

    if (_timeSchedule != null) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchTimeScheduleByCompanyId(int companyId) async {
    _isLoading = true;
    notifyListeners();

    print('find TimeSchedule by company Id');

    _timeSchedules = [];

    _timeSchedules = await TimeScheduleDao.db
        .getTimeScheduleByCompanyID(companyId);

    if (_timeSchedules.length > 0) {
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
