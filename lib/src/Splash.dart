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
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
          return new LoginScreen();
        }));
      });
    } else {
      print('token is not null');
      var duration = const Duration(seconds: 2);
      Timer(duration, () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
          return new Navigation();
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 853.3),
      builder: () => new Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Waste Collection', style: TextStyle(color: Color(0xFFF8C503), fontFamily: 'DiodrumCyrillicBold', fontSize: 26.sp),),
          )
        ),
      )
    );
  }
}