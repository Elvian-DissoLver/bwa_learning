import 'dart:async';

import 'package:bwa_learning/dao/talim/InstructorDao.dart';
import 'package:bwa_learning/models/talim/Instructor.dart';
import 'package:scoped_model/scoped_model.dart';

mixin InstructorModel on Model {
  List<Instructor> _instructors = [];
  List<Instructor> _foundedInstructor = [];
  Instructor _instructor;
  bool _isLoading = false;

  List<Instructor> get instructors {
    return List.from(_instructors);
  }

  List<Instructor> get foundedInstructor {
    return List.from(_foundedInstructor);
  }

  bool get isLoading {
    return _isLoading;
  }

  Instructor get currentInstructor {
    return _instructor;
  }

  void setCurrentInstructor(Instructor instructor) {
    _instructor = instructor;
  }

  Future<Null> fetchInstructorByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _instructors = [];

    print('fetch instructors by institutionId');

    try {
      _instructors = await InstructorDao.db.getInstructorByInstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchInstructorById(int instructorId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch instructor by id');

    try {
      await InstructorDao.db.getInstructorById(instructorId).then((onValue) {
        _instructor = onValue;
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

  Future<bool> fetchInstructorByEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    print('fetch instructor by email');

    try {
      await InstructorDao.db.getInstructorByEmail(email).then((onValue) {
        _instructor = onValue;
      });

      print("teacher: "+_instructor.name);
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
