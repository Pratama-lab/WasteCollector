// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, unnecessary_const, duplicate_ignore, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'WhatHappen.dart';

class HelpCentreScreen extends StatefulWidget {
  @override
  _HelpCentreState createState() => _HelpCentreState();
}

class _HelpCentreState extends State<HelpCentreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(260),
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 260,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/profile/group_2239.png'),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(children: [
                            GestureDetector(
                                onTap: () => Navigator.pop(context, true),
                                child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white)),
                            Container(
                                width: 320,
                                alignment: Alignment.center,
                                child: const Text('Help Centre',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22)))
                          ])),
                      Container(
                          padding: const EdgeInsets.only(top: 35),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future: ApiGetHomeData().getData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      var profile = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Text(
                                            'Hi ${profile.data.fullName},',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18));
                                      }
                                      return Container(
                                          width: 100,
                                          height: 10,
                                          child: const LoadingIndicator(
                                              indicatorType:
                                                  Indicator.ballPulse,
                                              colors: [Colors.white],
                                              backgroundColor:
                                                  Colors.transparent));
                                    }),
                                const Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text('We Are Ready',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20)),
                                ),
                                const Text('To Help You',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20))
                              ]))
                    ]))),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDEDEDE),
                      borderRadius: BorderRadius.circular(16.7)),
                  child: Row(children: [
                    Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Image.asset('images/profile/search_icon.png',
                            width: 22)),
                    Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 310,
                        child: TextFormField(
                            style: const TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            decoration: const InputDecoration(
                                hintText: 'Search help',
                                hintStyle: TextStyle(
                                    color: Color(0xFF707070),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                border: InputBorder.none)))
                  ]))),
          Container(
              padding: const EdgeInsets.only(
                  top: 29, bottom: 24, left: 20, right: 20),
              child: const Text('All Topics',
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontWeight: FontWeight.w700,
                      fontSize: 18))),
          Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Coming Soon',
                        backgroundColor: const Color(0xFFF8C503),
                        fontSize: 18,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Frequently Asked Questions',
                            style: TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF707070))
                      ]))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: Color(0xFFDEDEDE)))))),
          Container(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Coming Soon',
                        backgroundColor: const Color(0xFFF8C503),
                        fontSize: 18,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Payment Issue',
                            style: TextStyle(
                                color: const Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF707070))
                      ]))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  decoration: const BoxDecoration(
                      border: const Border(
                          bottom: BorderSide(
                              width: 1.0, color: const Color(0xFFDEDEDE)))))),
          Container(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Coming Soon',
                        backgroundColor: const Color(0xFFF8C503),
                        fontSize: 18,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('About My Account',
                            style: TextStyle(
                                color: const Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF707070))
                      ]))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: Color(0xFFDEDEDE)))))),
          Container(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Coming Soon',
                        backgroundColor: const Color(0xFFF8C503),
                        fontSize: 18,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('App Issue',
                            style: TextStyle(
                                color: const Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF707070))
                      ]))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: const BorderSide(
                              width: 1.0, color: const Color(0xFFDEDEDE)))))),
          Container(
              padding: const EdgeInsets.only(
                  top: 24, bottom: 23, left: 20, right: 20),
              child: const Text('Need Help With Your Recent Activity?',
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontWeight: FontWeight.w700,
                      fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WhatHappen())),
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 0.0,
                                offset: Offset(0, 1))
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 17.7, bottom: 8.5),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Color(0xFFDEDEDE)))),
                                child: Row(children: [
                                  Image.asset('images/profile/recycle_icon.png',
                                      width: 34, height: 33),
                                  Container(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: const Text(
                                          'Collection Successfully',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18)))
                                ])),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 11, bottom: 16.7),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('09:30 | 11 Jul 2021',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16)),
                                      const Text('Collection Nr.: 37432',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16))
                                    ]))
                          ])))),
          Container(
              padding: const EdgeInsets.only(
                  top: 31, bottom: 23, left: 20, right: 20),
              child: const Text('Find More Help',
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontWeight: FontWeight.w700,
                      fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  height: 121,
                  decoration: const BoxDecoration(
                      image: const DecorationImage(
                          image:
                              const AssetImage('images/profile/group_2237.png'),
                          fit: BoxFit.fill)),
                  child: Row(children: [
                    Container(width: 125),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text('Still Need Help?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17))),
                          Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text('Fastest way to get help',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17))),
                          Container(
                              padding: const EdgeInsets.only(top: 10, left: 30),
                              child: GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: 'Coming Soon',
                                        backgroundColor:
                                            const Color(0xFFF8C503),
                                        fontSize: 18,
                                        textColor: Colors.white,
                                        toastLength: Toast.LENGTH_SHORT);
                                  },
                                  child: Container(
                                      width: 158,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: const Text('Chat With Us',
                                          style: TextStyle(
                                              color: Color(0xFF263238),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17)))))
                        ])
                  ]))),
          Container(
              padding: const EdgeInsets.only(top: 21, bottom: 50),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Or you can',
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.w400,
                        fontSize: 18)),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Coming Soon',
                        backgroundColor: const Color(0xFFF8C503),
                        fontSize: 18,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: const Text(' MAIL US',
                      style: TextStyle(
                          color: Color(0xFFF8C503),
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                )
              ]))
        ])));
  }
}
