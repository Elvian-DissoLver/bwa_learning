import 'dart:async';

import 'package:bwa_learning/dao/CourseDao.dart';
import 'package:bwa_learning/models/Course.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CourseModel on Model {
  List<Course> _courses = [];
  List<Course> _foundedCourse = [];
  Course _course;
  bool _isLoading = false;

  List<Course> get courses {
    return List.from(_courses);
  }

  List<Course> get foundedCourse {
    return List.from(_foundedCourse);
  }

  bool get isLoading {
    return _isLoading;
  }

  Course get currentCourse {
    return _course;
  }

  void setCurrentCourse(Course course) {
    _course = course;
  }

  Future<Null> fetchCourseByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _courses = [];

    print('fetch courses by institutionId');

    try {
      _courses = await CourseDao.db.getCourseByInstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Null> fetchCourseByInstitutionIdAndTeacherId(int institutionId, int teacherId) async {
    _isLoading = true;
    notifyListeners();

    _courses = [];

    print('fetch courses by institutionId and teacherId');

    try {
      _courses = await CourseDao.db.getCourseByInstitutionIdAndTeacherId(institutionId, teacherId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
