import 'dart:async';

import 'package:bwa_learning/dao/origin/CourseStateDao.dart';
import 'package:bwa_learning/models/origin/CourseState.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CourseStateModel on Model {
  List<CourseState> _courseStates = [];
  List<CourseState> _foundedCourseState = [];
  CourseState _courseState;
  bool _isLoading = false;

  List<CourseState> get courseStates {
    return List.from(_courseStates);
  }

  List<CourseState> get foundedCourseState {
    return List.from(_foundedCourseState);
  }

  bool get isLoading {
    return _isLoading;
  }

  CourseState get currentCourseState {
    return _courseState;
  }

  void setCurrentCourseState(CourseState courseState) {
    _courseState = courseState;
  }

  Future<Null> fetchCourseStateByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _courseStates = [];

    print('fetch courseStates by institutionId');

    try {
      _courseStates = await CourseStateDao.db.getCourseStateByInstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool>fetchCourseStateByCourseIdAndClassId(int courseId, int classId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch students by email');

    try {
      await CourseStateDao.db.getCourseStateByCourseIdAndClassID(courseId, classId).then((onValue) {
        _courseState = onValue;
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
