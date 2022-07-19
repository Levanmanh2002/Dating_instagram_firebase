import 'package:dattings/datings/model/user_model.dart';
import 'package:dattings/datings/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AthuMethous _authMethous = AthuMethous();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethous.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
