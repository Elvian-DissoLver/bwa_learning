import 'dart:async';

import 'package:bwa_learning/dao/StudentDao.dart';
import 'package:bwa_learning/models/Student.dart';
import 'package:scoped_model/scoped_model.dart';

mixin StudentModel on Model {
  List<Student> _students = [];
  List<Student> _foundedStudent = [];
  Student _student;
  bool _isLoading = false;
//  ApiStudent _apiStudent = ApiStudent('student');

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

  Future<Null> fetchStudentByinstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _students = [];

    print('fetch students by institutionId');

    try {
      _students = await StudentDao.db.getStudentByinstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Null> fetchStudentByclassId(int classId) async {
    _isLoading = true;
    notifyListeners();

    _students = [];

    print('fetch students by classId');

    try {
      _students = await StudentDao.db.getStudentByclassId(classId, 1234);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchStudentByPhone(String finder) async {
    _isLoading = true;
    notifyListeners();

    _foundedStudent = [];

    print('fetch students by phone');

    try {
      _foundedStudent = await StudentDao.db.getStudentByPhone(finder, 1234);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStudent(Student updatedStudent) async {
    _isLoading = true;
    notifyListeners();

    try {
      print(updatedStudent.studentId);
      await StudentDao.db.updateStudentById(updatedStudent, updatedStudent.studentId);

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
