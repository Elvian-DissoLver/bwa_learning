

import 'package:bwa_learning/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User _user;

  Future<bool> signInAnonymously() async {
    final user = await auth.signInAnonymously();

    _user = User(
        uid: user.user.uid,
        email: user.user.email,
        token: user.user.uid,
        displayName: user.user.displayName,
        photoURL: user.user.photoUrl
    );
  }

  User get currentUser{
    return _user;
  }
}