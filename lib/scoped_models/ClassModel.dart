import 'dart:async';
import 'dart:math';

import 'package:bwa_learning/dao/ClassDao.dart';
import 'package:bwa_learning/models/Class.dart';
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

  Future<Null> fetchClassByIdInstitution(int idInstitution) async {
    _isLoading = true;
    notifyListeners();

    _classes = [];

    print('fetch kelas by idInstitution');

    try {
      _classes = await ClassDao.db.getClassByIdInstitution(idInstitution);

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

  Future<bool> findClassById(int idClass) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchClass = await ClassDao.db.getClassById(idClass, 1234);

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

    if (newClass.idClass == null) {
      newClass.idClass = random.nextInt(999999);
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
      print(currentClass.idClass);
      await ClassDao.db.updateClassById(newClass, currentClass.idClass);

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
