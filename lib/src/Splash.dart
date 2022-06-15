// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_new, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './Login.dart';
import './navigation/Navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  void startLaunching() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      var duration = const Duration(seconds: 2);
      Timer(duration, () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } else {
      var duration = const Duration(seconds: 2);
      Timer(duration, () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Navigation()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text('Waste Collection',
                style: TextStyle(
                    color: Color(0xFFF8C503),
                    fontWeight: FontWeight.w700,
                    fontSize: 24))));
  }
}
