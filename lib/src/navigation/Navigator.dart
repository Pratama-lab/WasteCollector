// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_collection/src/pages/home/Home.dart';
import 'package:waste_collection/src/pages/input/Input.dart';
import 'package:waste_collection/src/pages/message/Message.dart';
import 'package:waste_collection/src/pages/profile/Profile.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  DateTime timeBackPressed = DateTime.now();
  int _bottomNavIndex = 0;
  List<Widget> container = [
    const HomeScreen(),
    InputScreen(),
    MessageScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if (isExitWarning) {
            Fluttertoast.showToast(
                msg: 'Tekan lagi untuk keluar',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: const Color(0xFFF8C503));
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
            extendBody: true,
            body: container[_bottomNavIndex],
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    bottom: 24.1, left: 62.1, right: 62.1),
                color: Colors.transparent,
                child: Container(
                    height: 72.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1))
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () => setState(() => _bottomNavIndex = 0),
                              child: Image.asset('images/icons/home.png',
                                  width: 26,
                                  height: 26,
                                  color: _bottomNavIndex == 0
                                      ? const Color(0xFFF7D345)
                                      : const Color(0xFF707070))),
                          GestureDetector(
                              onTap: () => setState(() => _bottomNavIndex = 1),
                              child: Image.asset('images/icons/scan.png',
                                  width: 26,
                                  height: 26,
                                  color: _bottomNavIndex == 1
                                      ? const Color(0xFFF7D345)
                                      : const Color(0xFF707070))),
                          GestureDetector(
                              onTap: () => setState(() => _bottomNavIndex = 2),
                              child: Image.asset('images/icons/message.png',
                                  width: 26,
                                  height: 26,
                                  color: _bottomNavIndex == 2
                                      ? const Color(0xFFF7D345)
                                      : const Color(0xFF707070))),
                          GestureDetector(
                              onTap: () => setState(() => _bottomNavIndex = 3),
                              child: Image.asset('images/icons/user.png',
                                  width: 26,
                                  height: 26,
                                  color: _bottomNavIndex == 3
                                      ? const Color(0xFFF7D345)
                                      : const Color(0xFF707070)))
                        ])))));
  }
}
