import 'dart:async';

import 'package:bwa_learning/api/ApiStudent.dart';
import 'package:bwa_learning/models/Student.dart';
import 'package:scoped_model/scoped_model.dart';

mixin StudentModel on Model {

  List<Student> _students = [];
  Student _student;
  bool _isLoading = false;
  ApiStudent _apiStudent = ApiStudent('student');

  List<Student> get students {
    return List.from(_students);
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

  Future<Null> fetchStudent() async{
    _isLoading = true;
    notifyListeners();

    _students = [];

    print('fetch students');

    _apiStudent.setIdInstitution('1234');

    try {
      var result = await _apiStudent.getDataCollection();

      result.documents
          .forEach((doc) {
        print(doc.data);
        _students.add(Student.fromJson(doc.data, doc.documentID));

        _students.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<Null> fetchStudentByIdKelas(String idKelas) async{
    _isLoading = true;
    notifyListeners();

    _students = [];

    print('fetch students');

    _apiStudent.setIdInstitution('1234');

    try {
      var result = await _apiStudent.getDataCollectionByIdClass(idKelas);

      result.documents
          .forEach((doc) {
        print(doc.data);
        _students.add(Student.fromJson(doc.data, doc.documentID));

        _students.sort((a, b) {
          return a.fullName.compareTo(b.fullName);
        });
      });

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }

  }
}

