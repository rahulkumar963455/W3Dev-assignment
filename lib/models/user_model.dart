// Model Class
class AppUser {
  final int? uid;
  final String username;
  final String useremail;
  final String userprofilepic;

  AppUser({this.uid, required this.username, required this.useremail, required this.userprofilepic});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'useremail': useremail,
      'userprofilepic': userprofilepic,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      username: map['username'],
      useremail: map['useremail'],
      userprofilepic: map['userprofilepic'],
    );
  }
}
