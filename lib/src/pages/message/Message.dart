// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_new, sized_box_for_whitespace, unnecessary_const, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => new _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int index = 0;
  final List<String> chat = <String>['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: MediaQuery.of(context).size.width,
          height: 280,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
          child: Container(
              padding: const EdgeInsets.only(top: 50),
              child: Column(children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text('Message',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      width: 175,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () => setState(() => index = 0),
                              child: Container(
                                  width: 140,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: index == 0 ? 0.0 : 1.0,
                                          color: index == 0
                                              ? Colors.transparent
                                              : Colors.white),
                                      borderRadius: BorderRadius.circular(16.7),
                                      gradient: index == 0
                                          ? const LinearGradient(colors: [
                                              const Color(0xFFF8C503),
                                              Color(0xFFFFE067)
                                            ])
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                            color: index == 0
                                                ? Colors.grey
                                                : Colors.transparent,
                                            blurRadius: index == 0 ? 2 : 0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(0, 1))
                                      ]),
                                  child: Center(
                                      child: Text('Chat',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: index == 0
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                              fontSize: 20))))))),
                  Container(
                      width: 175,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () => setState(() => index = 1),
                              child: Container(
                                  width: 140,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: index == 1 ? 0.0 : 1.0,
                                          color: index == 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      borderRadius: BorderRadius.circular(16.7),
                                      gradient: index == 1
                                          ? const LinearGradient(colors: [
                                              Color(0xFFF8C503),
                                              const Color(0xFFFFE067)
                                            ])
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                            color: index == 1
                                                ? Colors.grey
                                                : Colors.transparent,
                                            blurRadius: index == 1 ? 2 : 0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(0, 1))
                                      ]),
                                  child: Center(
                                      child: Text('Inbox',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: index == 1
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                              fontSize: 20)))))))
                ])
              ]))),
      if (index == 0) ...[
        Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topCenter,
                child: Column(children: [
                  Lottie.asset('images/animations/coming_soon.json',
                      height: 200),
                  Lottie.asset('images/animations/coming_soon_2.json',
                      height: 300)
                ])))
      ] else if (index == 1) ...[
        Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                child: Column(children: [
                  Lottie.asset('images/animations/coming_soon.json',
                      height: 200),
                  Lottie.asset('images/animations/coming_soon_2.json',
                      height: 300)
                ])))
      ]
    ]));
  }
}
