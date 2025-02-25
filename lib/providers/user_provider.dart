import 'package:flutter/cupertino.dart';

import '../databases/user_database.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<AppUser> _users = [];
  List<NotificationData> _notifications = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<AppUser> get users => _users;
  List<NotificationData> get notifications => _notifications;

  Future<void> addUser(AppUser user) async {
    await _dbHelper.insertUser(user);
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    _users = await _dbHelper.fetchUsers();
    notifyListeners();
  }

  Future<void> deleteUser(int uid) async {
    await _dbHelper.deleteUser(uid);
    await fetchUsers();
  }

  // Notification methods
  Future<void> addNotification(NotificationData notification) async {
    await _dbHelper.insertNotification(notification);
    await fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    _notifications = await _dbHelper.fetchNotifications();
    notifyListeners();
  }

  Future<void> deleteNotification(int id) async {
    await _dbHelper.deleteNotification(id);
    await fetchNotifications();
  }
}