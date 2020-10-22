import 'package:demo/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animation/fade_animation.dart';
import '../constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeLogin = '/login';
  String userName;
  String password;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _login() async {
      if (userName == 'admin' && password == 'admin') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasLogin', true);
        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        await _showMyDialog(context);
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              mPrimaryColor,
              mDarkBlue2,
              mDarkBlue1,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: screenSize.width / 4),
              height: screenSize.height / 4,
              width: screenSize.width / 2,
              child: FadeAnimation(
                1.5,
                Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                              1,
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                    225,
                                    95,
                                    27,
                                    .3,
                                  ),
                                  blurRadius: 20,
                                  offset: Offset(
                                    0,
                                    10,
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]),
                                    ),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      context
                                          .read<LoginViewModel>()
                                          .checkEmptyUserName(value);
                                      userName = value;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]),
                                    ),
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      context
                                          .read<LoginViewModel>()
                                          .checkEmptyPassword(value);
                                      password = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
                          ButtonTheme(
                            minWidth: screenSize.width / 2.5,
                            child: RaisedButton(
                              color: mDarkBlue2,
                              onPressed: context
                                      .watch<LoginViewModel>()
                                      .isButtonEnabled()
                                  ? _login
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              disabledColor: Colors.blueGrey[200],
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          content: Text('Username or Password is invalid !!!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
