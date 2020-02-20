import 'dart:async';

import 'package:bwa_learning/dao/talim/StudentDao.dart';
import 'package:bwa_learning/models/talim/Student.dart';
import 'package:scoped_model/scoped_model.dart';

mixin StudentModel on Model {
  List<Student> _students = [];
  List<Student> _foundedStudent = [];
  Student _student;
  bool _isLoading = false;

  List<Student> get students {
    return List.from(_students);
  }

  List<Student> get foundedStudent {
    return List.from(_foundedStudent);
  }

  bool get isLoading {
    return _isLoading;
  }

  Student get currentStudent {
    return _student;
  }

  void setCurrentStudent(Student student) {
    _student = student;
  }

  Future<bool> fetchStudentById(int studentId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch student by id');

    try {
      await StudentDao.db.getStudentById(studentId).then((onValue) {
        _student = onValue;
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

  Future<bool> fetchStudentByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch student by institutionId');

    _students = [];

    try {
      _students = await StudentDao.db.getStudentByInstitutionID(institutionId);

      if (_students.length > 0) {
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

  Future<bool> fetchStudentByEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    print('fetch students by email');

    await StudentDao.db.getStudentByEmail(email).then((onValue) {
      _student = onValue;
    });

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
