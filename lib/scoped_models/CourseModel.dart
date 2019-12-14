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

  Future<Null> fetchCourseByIdInstitution(int idInstitution) async {
    _isLoading = true;
    notifyListeners();

    _courses = [];

    print('fetch courses by idInstitution');

    try {
      _courses = await CourseDao.db.getCourseByIdInstitution(idInstitution);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
