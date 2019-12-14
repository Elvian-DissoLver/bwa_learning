import 'dart:async';

import 'package:bwa_learning/dao/ScheduleCourseDao.dart';
import 'package:bwa_learning/models/ScheduleCourse.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ScheduleCourseModel on Model {
  List<ScheduleCourse> _scheduleCourses = [];
  bool _isLoading = false;

  List<ScheduleCourse> get scheduleCourses {
    return List.from(_scheduleCourses);
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Null> fetchScheduleCourseByIdClass(int idClass) async {
    _isLoading = true;
    notifyListeners();

    _scheduleCourses = [];

    print('fetch scheduleCourses by idClass');

    try {
      _scheduleCourses = await ScheduleCourseDao.db.getScheduleCourseByIdClass(idClass, 1234);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
