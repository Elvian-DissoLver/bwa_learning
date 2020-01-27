class User {
  int userId;
  String email;
  String userName;
  String password;
  String token;
  String displayName;
  String photoURL;
  String status;

  User({
    this.userId,
    this.email,
    this.userName,
    this.status
  });

  User.fromJson(Map<String, dynamic> map) {
    this.userId = map['userId'];
    userName = map['userName'];
    email = map['email'];
    status = map['status'];
   }
}