import '/model/User.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  User? _currentUser;
  void ChangeUser(User? user) {
    this._currentUser = user;
    notifyListeners();
  }
  getUser()
  {
    return _currentUser;
  }
}
