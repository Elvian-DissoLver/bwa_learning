import 'dart:async';
import 'package:bwa_learning/dao/talim/InstitutionDao.dart';
import 'package:bwa_learning/models/talim/Institution.dart';
import 'ClassesModel.dart';

mixin InstitutionModel on CoreModel {
  List<Institution> _institutions = [];
  Institution _institution;
  Institution _searchInstitution;
  bool _isLoading = false;

  List<Institution> get institutions {
    return List.from(_institutions);
  }

  bool get isLoading {
    return _isLoading;
  }

  Institution get currentInstitution {
    return _institution;
  }

  Institution get searchInstitution {
    return _searchInstitution;
  }

  void setCurrentInstitution(Institution setInstitution) {
    _institution = setInstitution;
  }

  Future<Null> fetchInstitutionById(int institutionId) async {
    _isLoading = true;
    notifyListeners();

    print('fetch kelas by institutionId');

    try {
      _institution= await InstitutionDao.db.getInstitutionById(institutionId);

      print(_institution.institutionName);


      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }

}
