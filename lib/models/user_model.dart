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

// Notification Model Class
class NotificationData {
  final int? id;
  final String title;
  final String message;
  final String timestamp;

  NotificationData({this.id, required this.title, required this.message, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}
