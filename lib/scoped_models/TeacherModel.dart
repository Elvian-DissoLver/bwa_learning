import 'dart:async';

import 'package:bwa_learning/dao/TeacherDao.dart';
import 'package:bwa_learning/models/Teacher.dart';
import 'package:scoped_model/scoped_model.dart';

mixin TeacherModel on Model {
  List<Teacher> _teachers = [];
  List<Teacher> _foundedTeacher = [];
  Teacher _teacher;
  bool _isLoading = false;

  List<Teacher> get teachers {
    return List.from(_teachers);
  }

  List<Teacher> get foundedTeacher {
    return List.from(_foundedTeacher);
  }

  bool get isLoading {
    return _isLoading;
  }

  Teacher get currentTeacher {
    return _teacher;
  }

  void setCurrentTeacher(Teacher teacher) {
    _teacher = teacher;
  }

  Future<Null> fetchTeacherByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _teachers = [];

    print('fetch teachers by institutionId');

    try {
      _teachers = await TeacherDao.db.getTeacherByInstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchTeacherById(int teacherId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch teacher by id');

    try {
      await TeacherDao.db.getTeacherById(teacherId).then((onValue) {
        _teacher = onValue;
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

  Future<bool> fetchTeacherByEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    print('fetch teacher by email');

    try {
      await TeacherDao.db.getTeacherByEmail(email).then((onValue) {
        _teacher = onValue;
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
