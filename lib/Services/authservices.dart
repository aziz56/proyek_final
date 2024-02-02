import 'dart:io';

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isLogin = true;
  bool _isAuth = false;
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';
  File? _Image;

  void changeAuthImage(File? image) {
    _Image = image;
    notifyListeners();
  }

  void changeIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void changeIsAuth() {
    _isAuth = !_isAuth;
    notifyListeners();
  }
  void changeEnteredEmail(String email) {
    _enteredEmail = email;
    notifyListeners();
  }
  void changeEnteredPassword(String password) {
    _enteredPassword = password;
    notifyListeners();
  }
  void changeEnteredUsername(String username) {
    _enteredUsername = username;
    notifyListeners();
    
  }
  File? getimage() => _Image;

  bool getisLogin() => _isLogin;

  bool getIsAuth() => _isAuth;

  String getEnteredEmail() => _enteredEmail;

  String getEnteredPassword() => _enteredPassword;

  String getEnteredUsername() => _enteredUsername;
}

