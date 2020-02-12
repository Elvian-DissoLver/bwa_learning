import 'dart:async';
import 'package:bwa_learning/dao/talim/ScheduleDao.dart';
import 'package:bwa_learning/models/talim/Schedule.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ScheduleModel on Model {
  List<Schedule> _schedules = [];
  List<Schedule> _foundedSchedule = [];
  Schedule _schedule;
  bool _isLoading = false;

  List<Schedule> get schedules {
    return List.from(_schedules);
  }

  List<Schedule> get foundedSchedule {
    return List.from(_foundedSchedule);
  }

  void setLoading(bool load){
    _isLoading = load;
  }

  bool get isLoading {
    return _isLoading;
  }

  Schedule get currentSchedule {
    return _schedule;
  }

  void setCurrentSchedule(
      Schedule schedule) {
    _schedule = schedule;
  }


  Future<bool> findScheduleById(int scheduleId) async {
    _isLoading = true;
    notifyListeners();

    print('find Schedule by id');

    _schedule = await ScheduleDao.db
        .getScheduleById(scheduleId);

    if (_schedule != null) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchScheduleByTimeScheduleId(int timeScheduleId) async {
    _isLoading = true;
    notifyListeners();

    print('find Schedule by TimeSchedule id');

    _schedules = await ScheduleDao.db
        .getScheduleByTimeScheduleId(timeScheduleId);

    if (_schedules.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchScheduleByCompanyId(int timeScheduleId) async {
    _isLoading = true;
    notifyListeners();

    print('find Schedule by Company id');

    _schedules = await ScheduleDao.db
        .getScheduleByCompanyId(timeScheduleId);

    if (_schedules.length > 0) {
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
