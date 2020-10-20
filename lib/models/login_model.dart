import 'package:flutter/material.dart';

class Login {
  String userName;
  String password;

  Login({this.userName, this.password});
}

class LoginViewModel with ChangeNotifier {
  bool userNameFlag = false;
  bool passwordFlag = false;
  void checkEmptyUserName(String value) => userNameFlag = value.isNotEmpty;

  void checkEmptyPassword(String value) => passwordFlag = value.isNotEmpty;

  bool isButtonEnabled() => (userNameFlag && passwordFlag);
}
