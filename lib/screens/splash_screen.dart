import 'dart:async';

import 'package:demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<Timer> startTimer() async {
    final duration = Duration(seconds: 3);
    return Timer(duration, _getSharedPreference);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Welcome to movie app',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 4.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasLogin;
    hasLogin = prefs.getBool('hasLogin');
    if (hasLogin != null) {
      await Navigator.pushReplacementNamed(context, '/home');
    } else {
      await Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
