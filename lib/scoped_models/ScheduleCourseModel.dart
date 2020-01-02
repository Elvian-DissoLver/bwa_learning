import 'dart:async';

import 'package:bwa_learning/dao/ScheduleCourseDao.dart';
import 'package:bwa_learning/models/ScheduleCourse.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ScheduleCourseModel on Model {
  List<ScheduleCourse> _scheduleCourses = [];
  bool _isLoading = false;
  ScheduleCourse _scheduleCourse;

  void setCurrentScheduleCourse(ScheduleCourse scheduleCourse) {
    _scheduleCourse = scheduleCourse;
  }

  ScheduleCourse get currentScheduleCourse{
    return _scheduleCourse;
  }

  List<ScheduleCourse> get scheduleCourses {
    return List.from(_scheduleCourses);
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Null> fetchScheduleCourseByClassId(int classId) async {
    _isLoading = true;
    notifyListeners();

    _scheduleCourses = [];

    print('fetch scheduleCourses by classId');

    try {
      _scheduleCourses = await ScheduleCourseDao.db.getScheduleCourseByClassId(classId, 1234);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Null> fetchScheduleCourseByTeacherId(int teacherId) async {
    _isLoading = true;
    notifyListeners();

    _scheduleCourses = [];

    print('fetch scheduleCourses by teacherId');

    try {
      _scheduleCourses = await ScheduleCourseDao.db.getScheduleCourseByTeacherId(teacherId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
