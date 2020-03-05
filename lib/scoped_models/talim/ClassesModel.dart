import 'dart:async';
import 'package:bwa_learning/dao/talim/ClassDao.dart';
import 'package:bwa_learning/models/talim/Class.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CoreModel on Model {
  List<Class> _classes = [];
  Class _class;
  Class _searchClass;
  bool _isLoading = false;
}

mixin ClassesModel on CoreModel {
  List<Class> get classes {
    return List.from(_classes);
  }

  bool get isLoading {
    return _isLoading;
  }

  Class get currentClass {
    return _class;
  }

  Class get searchClass {
    return _searchClass;
  }

  void setCurrentClass(Class setClass) {
    _class = setClass;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  Future<bool> fetchClassByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _classes = [];

    print('fetch kelas by institutionId');

    _classes = await ClassDao.db.getClassByInstitutionId(institutionId);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> fetchClassByTrainingClassId(int trainingClassId) async {
    _isLoading = true;
    notifyListeners();

    _classes = [];

    print('fetch kelas by TrainingClassId');

    _classes = await ClassDao.db.getClassByTrainingClassId(trainingClassId);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> fetchClassByInstitutionIDAndInstructorID(
      int institutionID, int instructorID) async {
    _isLoading = true;
    notifyListeners();

    _classes = [];

    print('fetch kelas by institutionId and instructorId');

    _classes = await ClassDao.db
        .getClassByInstitutionAndInstructorID(institutionID, instructorID);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> findClassByName(String className) async {
    _isLoading = true;
    notifyListeners();

    try {
      var result = await ClassDao.db.getClassByName(className, 1234);

      if (result != null) {
        _isLoading = false;
        notifyListeners();
        print('woilop');
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

  Future<bool> findStudentClassById(int classId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await ClassDao.db.getClassById(classId).then((onValue) {
        _class = onValue;
      });

      if (_searchClass != null) {
        _isLoading = false;
        notifyListeners();

        print(_searchClass.classNo);

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

  Future<bool> findClassById(var classId) async {
    _isLoading = true;
    notifyListeners();

    _searchClass = await ClassDao.db.getClassById(classId);

    if (_searchClass != null) {
      _isLoading = false;
      notifyListeners();

      print(_searchClass.classNo);

      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
