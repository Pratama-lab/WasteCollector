// ignore_for_file: file_names, unnecessary_import, use_key_in_widget_constructors, unnecessary_const, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShareFeedbackScreen extends StatefulWidget {
  @override
  _ShareFeedbackState createState() => _ShareFeedbackState();
}

class _ShareFeedbackState extends State<ShareFeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: 280,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('images/profile/mask_group_30.png'),
                  fit: BoxFit.cover)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.only(top: 50),
                child: Row(children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white)),
                  Container(
                      width: 320,
                      alignment: Alignment.center,
                      child: const Text('Share Feedback',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22)))
                ])),
            Container(
                padding: const EdgeInsets.only(top: 25),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                    'Every Feeadback helps. \nWhat can we improve on?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    textAlign: TextAlign.center))
          ])),
      Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Container(
              transform: Matrix4.translationValues(0.0, -80.0, 0.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 3.0, color: const Color(0xFF2AAE1B))),
              child: Center(
                  child: Image.asset('images/profile/volunteering_bro_1.png',
                      width: 150, height: 150)))),
      Container(
          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
          width: MediaQuery.of(context).size.width,
          child: const Text('Waste Collector',
              style: TextStyle(
                  color: const Color(0xFF707070),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              textAlign: TextAlign.center)),
      Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: const Color(0xFFDEDEDE),
                  borderRadius: BorderRadius.circular(16.7)),
              child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF707070),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                      hintText: 'Tell us your thought',
                      border: InputBorder.none)))),
      Container(
          padding: const EdgeInsets.only(top: 50, left: 35, right: 35),
          child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: 'Coming Soon',
                    backgroundColor: const Color(0xFFF8C503),
                    fontSize: 18,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT);
              },
              child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8C503),
                      borderRadius: BorderRadius.circular(16.7),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 0.0,
                            offset: Offset(0, 1))
                      ]),
                  alignment: Alignment.center,
                  child: const Text('Send Feedback',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20)))))
    ])));
  }
}
