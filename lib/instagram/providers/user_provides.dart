import 'package:dattings/instagram/modeis.dart/user.dart';
import 'package:dattings/instagram/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethous _authMethous = AuthMethous();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethous.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
