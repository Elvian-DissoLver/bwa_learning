
import 'package:bwa_learning/dao/origin/UserDao.dart';
import 'package:bwa_learning/models/origin/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User _user;

  bool _isLoading = false;

  User get currentUser{
    return _user;
  }

  Future<bool> findUserByEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    print('find user by email');

    try {
      await UserDao.db.getUserByEmail(email).then((onValue) {
        _user =onValue;
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
}