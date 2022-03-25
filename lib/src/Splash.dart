// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      print('token is null');
      var duration = const Duration(seconds: 2);
      Timer(duration, () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => LoginScreen() ));
      });
    } else {
      print('token is not null');
      var duration = const Duration(seconds: 2);
      Timer(duration, () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Navigation()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 853.3),
      builder: () => new Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Waste Collection', style: TextStyle(color: const Color(0xFFF8C503), fontFamily: 'DiodrumCyrillicBold', fontSize: 26.sp),),
          )
        ),
      )
    );
  }
}