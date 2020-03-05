import 'package:bwa_learning/dao/talim/UserDao.dart';
import 'package:bwa_learning/models/talim/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User _user;

  bool _isLoading = false;

  User get currentUser {
    return _user;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<bool> findUserByEmail(String email) async {
    _isLoading = true;
    notifyListeners();

    print('find user by email');

    _user = await UserDao.db.getUserByEmail(email);

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
