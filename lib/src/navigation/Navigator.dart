// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:waste_collection/src/pages/home/Home.dart';
import 'package:waste_collection/src/pages/input/Input.dart';
import 'package:waste_collection/src/pages/message/Message.dart';
import 'package:waste_collection/src/pages/profile/Profile.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _bottomNavIndex = 0;
  List<Widget> container = [ const HomeScreen(), InputScreen(), MessageScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        extendBody: true,
        body: container[_bottomNavIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 24.1, left: 62.1, right: 62.1),
          color: Colors.transparent,
          child: Container(
            height: ScreenUtil().setHeight(72.4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 0 ),
                  child: Image.asset('images/icons/home.png', width: 26, height: 26, color: _bottomNavIndex == 0 ? const Color(0xFFF7D345) : const Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 1 ),
                  child: Image.asset('images/icons/scan.png', width: 26, height: 26, color: _bottomNavIndex == 1 ? const Color(0xFFF7D345) : const Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 2 ),
                  child: Image.asset('images/icons/message.png', width: 26, height: 26, color: _bottomNavIndex == 2 ? const Color(0xFFF7D345) : const Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 3 ),
                  child: Image.asset('images/icons/user.png', width: 26, height: 26, color: _bottomNavIndex == 3 ? const Color(0xFFF7D345) : const Color(0xFF707070))
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}