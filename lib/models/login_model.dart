import 'package:flutter/material.dart';

class Login {
  String userName;
  String password;

  Login({this.userName, this.password});
}

class LoginViewModel with ChangeNotifier {
  bool userNameFlag = false;
  bool passwordFlag = false;
  void isInputUserName(String value) => userNameFlag = (value != "");

  void isInputPassword(String value) => passwordFlag = (value != "");

  bool isButtonEnabled() => (userNameFlag && passwordFlag);
}
