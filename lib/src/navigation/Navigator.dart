import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../module/home/Home.dart';
import '../module/input/Input.dart';
import '../module/message/Message.dart';
import '../module/profile/Profile.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => new _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _bottomNavIndex = 0;
  List<Widget> _container = [new HomeScreen(), new InputScreen(), new MessageScreen(), new ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        extendBody: true,
        body: _container[_bottomNavIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 24.1, left: 62.1, right: 62.1),
          color: Colors.transparent,
          child: Container(
            height: ScreenUtil().setHeight(72.4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 0 ),
                  child: _bottomNavIndex == 0 ? Image.asset('images/icons/home.png', width: 26, height: 26, color: Color(0xFFF7D345)) : Image.asset('images/icons/home.png', width: 26, height: 26, color: Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 1 ),
                  child: _bottomNavIndex == 1 ? Image.asset('images/icons/scan.png', width: 26, height: 26, color: Color(0xFFF7D345)) : Image.asset('images/icons/scan.png', width: 26, height: 26, color: Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 2 ),
                  child: _bottomNavIndex == 2 ? Image.asset('images/icons/message.png', width: 26, height: 26, color: Color(0xFFF7D345)) : Image.asset('images/icons/message.png', width: 26, height: 26, color: Color(0xFF707070))
                ),

                TouchableOpacity(
                  onTap: () => setState(() => _bottomNavIndex = 3 ),
                  child: _bottomNavIndex == 3 ? Image.asset('images/icons/user.png', width: 26, height: 26, color: Color(0xFFF7D345)) : Image.asset('images/icons/user.png', width: 26, height: 26, color: Color(0xFF707070))
                ),
              ],
            ),
          ),
        )
      ));
  }
}