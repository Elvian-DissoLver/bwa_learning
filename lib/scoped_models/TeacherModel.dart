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

  Future<Null> fetchTeacherByIdInstitution(int idInstitution) async {
    _isLoading = true;
    notifyListeners();

    _teachers = [];

    print('fetch teachers by idInstitution');

    try {
      _teachers = await TeacherDao.db.getTeacherByIdInstitution(idInstitution);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
