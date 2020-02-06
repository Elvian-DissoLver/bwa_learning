import 'dart:async';
import 'dart:math';
import 'package:bwa_learning/dao/origin/ClassDao.dart';
import 'package:bwa_learning/models/origin/Class.dart';
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

  Future<Null> fetchClassByInstitutionId(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    _classes = [];

    print('fetch kelas by institutionId');

    try {
      _classes = await ClassDao.db.getClassByInstitutionId(institutionId);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> findClassByName(String className) async {
    _isLoading = true;
    notifyListeners();

    try {
      var result = await ClassDao.db.getClassByName(className, 1234);

      if (result!=null) {
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
      await ClassDao.db.getClassById(classId, 1234).then((onValue) {
        _class = onValue;
      });

      if (_searchClass != null) {
        _isLoading = false;
        notifyListeners();

        print(_searchClass.className);

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

  Future<bool> findClassById(int classId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await ClassDao.db.getClassById(classId, 1234).then((onValue) {
        _searchClass = onValue;
      });

      if (_searchClass != null) {
        _isLoading = false;
        notifyListeners();

        print(_searchClass.className);

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

  Future<bool> createClass(Class newClass) async {
    _isLoading = true;
    notifyListeners();

    var random = Random.secure();

    if (newClass.classId == null) {
      newClass.classId = random.nextInt(999999);
    }

    try {
      await ClassDao.db.addClass(newClass);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateClass(Class newClass) async {
    _isLoading = true;
    notifyListeners();

    try {
      print(currentClass.classId);
      await ClassDao.db.updateClassById(newClass, currentClass.classId);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

//  Future<bool> removeKelas(String id) async {
//    _isLoading = true;
//    notifyListeners();
//
//    try {
//      int kelasIndex = _kelases.indexWhere((t) => t.idKelas == id);
//      _kelases.removeAt(kelasIndex);
//
//      await _apiKelases.removeDocument(id);
//
//      _isLoading = false;
//      notifyListeners();
//
//      return true;
//    } catch (error) {
//      _isLoading = false;
//      notifyListeners();
//
//      return false;
//    }
//  }
}
