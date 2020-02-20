import 'dart:async';
import 'package:bwa_learning/dao/talim/TrainingClassDao.dart';
import 'package:bwa_learning/models/talim/TrainingClass.dart';
import 'package:scoped_model/scoped_model.dart';

mixin TrainingClassModel on Model {
  List<TrainingClass> _trainingClasses = [];
  List<TrainingClass> _foundedTrainingClass = [];
  TrainingClass _trainingClass;
  bool _isLoading = false;

  List<TrainingClass> get trainingClasses {
    return List.from(_trainingClasses);
  }

  List<TrainingClass> get foundedTrainingClass {
    return List.from(_foundedTrainingClass);
  }

  bool get isLoading {
    return _isLoading;
  }

  TrainingClass get currentTrainingClass {
    return _trainingClass;
  }

  void setCurrentTrainingClass(TrainingClass trainingClass) {
    _trainingClass = trainingClass;
  }

  void setLoading2(bool loading){
    _isLoading = loading;
  }

  Future<bool> fetchTrainingClassByCompanyId(
      int companyID) async {
    _isLoading = true;
    notifyListeners();

    _trainingClasses = [];

    print('fetch trainingClasss by CompanyId');

    _trainingClasses =
        await TrainingClassDao.db.getTrainingClassByCompanyID(companyID);

    if (_trainingClasses.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
