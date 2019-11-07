import 'dart:async';

import 'package:bwa_learning/api/ApiKelases.dart';
import 'package:bwa_learning/models/Kelas.dart';
import 'package:scoped_model/scoped_model.dart';


mixin CoreModel on Model {
  List<Kelas> _kelases = [];
  Kelas _kelas;
  bool _isLoading = false;
  ApiKelases _apiKelases = ApiKelases('kelas');

}

mixin KelasesModel on CoreModel {
  List<Kelas> get kelases {
    return List.from(_kelases);
  }

  bool get isLoading {
    return _isLoading;
  }

  Kelas get currentKelas {
    return _kelas;
  }

  void setCurrentKelas(Kelas kelas) {
    _kelas = kelas;
  }

  Future<Null> fetchKelases() async{
    _isLoading = true;
    notifyListeners();

    _kelases = [];

    print('fetch kelas');

    _apiKelases.setIdInstitution('1234');

    try {
      var result = await _apiKelases.getDataCollection();

      result.documents
          .forEach((doc) {
        print(doc.data);
        _kelases.add(Kelas.fromJson(doc.data, doc.documentID));

        _kelases.sort((a, b) {
          return a.className.compareTo(b.className);
        });
      });

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<bool> createKelas(
      Kelas newKelas) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'className': newKelas.className,
      'level': newKelas.level,
      'teacherClass': newKelas.teacherClass,
      'idInstitution': newKelas.idInstitution
    };
    String id;
    try {

      await _apiKelases.addDocument(formData).then((onValue) {
        id = onValue.documentID;
      });

      _isLoading = false;
      notifyListeners();
      newKelas.idKelas = id;
      return true;
    }  catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

  }

  Future<bool> updateKelas(
      Kelas newKelas) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'className': newKelas.className,
      'level': newKelas.level,
      'teacherClass': newKelas.teacherClass,
      'idInstitution': newKelas.idInstitution
    };

    try {
      print(currentKelas.idKelas);
      await _apiKelases.updateDocument(formData, currentKelas.idKelas);

      _isLoading = false;
      notifyListeners();

      return true;
    }  catch (error) {
      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  Future<bool> removeKelas(String id) async {
    _isLoading = true;
    notifyListeners();

    try {

      int kelasIndex = _kelases.indexWhere((t) => t.idKelas == id);
      _kelases.removeAt(kelasIndex);

      await _apiKelases.removeDocument(id);

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

