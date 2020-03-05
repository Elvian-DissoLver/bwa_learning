import 'dart:async';
import 'package:bwa_learning/dao/talim/StudentProgressDao.dart';
import 'package:bwa_learning/models/talim/StudentProgress.dart';
import 'package:scoped_model/scoped_model.dart';

mixin StudentProgressModel on Model {
  List<StudentProgress> _studentProgresses = [];
  List<StudentProgress> _foundedStudentProgress = [];
  StudentProgress _studentProgress;
  bool _isLoading = false;

  List<StudentProgress> get studentProgresses {
    return List.from(_studentProgresses);
  }

  List<StudentProgress> get foundedStudentProgress {
    return List.from(_foundedStudentProgress);
  }

  bool get isLoading {
    return _isLoading;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  StudentProgress get currentStudentProgress {
    return _studentProgress;
  }

  void setCurrentStudentProgress(StudentProgress studentProgress) {
    _studentProgress = studentProgress;
  }

  Future<bool> fetchStudentProgressByTopicId(int topicID) async {
    _isLoading = true;
    notifyListeners();

    _studentProgresses = [];

    print('fetch studentProgresss by TopicId');

    _studentProgresses =
        await StudentProgressDao.db.getStudentProgressByTopicID(topicID);

    if (_studentProgresses.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchStudentProgressByClassIdAndTopicID(
      int classID, int topicID) async {
    _isLoading = true;
    notifyListeners();

    _studentProgresses = [];

    print('fetch studentProgresss by ClassId and TopicId');

    _studentProgresses = await StudentProgressDao.db
        .getStudentProgressByClassIDAndTopicID(classID, topicID);

    if (_studentProgresses.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchStudentProgressByStudentID(var studentID) async {
    _isLoading = true;
    notifyListeners();

    _studentProgresses = [];

    print('fetch studentProgresss by studentId');

    _studentProgresses =
        await StudentProgressDao.db.getStudentProgressByStudentID(studentID);

    if (_studentProgresses.length > 0) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchStudentProgressByClassIdTopicIDAndStudentId(
      int classID, int topicID, var studentID) async {
    _isLoading = true;
    notifyListeners();

    print('fetch studentProgresss by ClassId TopicId and StudentId');

    _studentProgress = await StudentProgressDao.db
        .getStudentProgressByClassIdTopicIDAndStudentId(
            classID, topicID, studentID);

    if (_studentProgress != null) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> findStudentProgressById(int studentProgressID) async {
    _isLoading = true;
    notifyListeners();

    print('find StudentProgress by id');

    _studentProgress =
        await StudentProgressDao.db.getStudentProgressById(studentProgressID);

    if (_studentProgress != null) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStudentProgressesByTeacher(
      List<StudentProgress> studentProgress) async {
    _isLoading = true;
    notifyListeners();
    print('update studentProgresses by Teacher');

    for (StudentProgress studentProgress in studentProgress) {
      await StudentProgressDao.db
          .updateStudentProgressByTeacher(studentProgress);
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future updateStudentProgressByStudent(StudentProgress studentProgress) async {
    _isLoading = true;
    notifyListeners();
    print('update studentProgress by student');
    await StudentProgressDao.db.updateStudentProgressByStudent(studentProgress);

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
