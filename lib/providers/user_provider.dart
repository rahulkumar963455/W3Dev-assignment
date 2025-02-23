import 'package:flutter/cupertino.dart';

import '../databases/user_database.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<AppUser> _users = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<AppUser> get users => _users;

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
}