// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';

class AddBankAccountScreen extends StatefulWidget {
  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  _onWillPop() {
    Navigator.pop(context, 'back');
  }

  @override
  Widget build(BuildContext) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Add Bank Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22)),
              centerTitle: true,
              backgroundColor: const Color(0xFFF8C503),
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context, 'back'),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white))),
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: const Text('Bank Name',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 17),
                        decoration: const InputDecoration(
                            hintText: 'BCA',
                            hintStyle: TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text('Your Account',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 17),
                        decoration: const InputDecoration(
                            hintText: 'Account Number',
                            hintStyle: TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text('Alias',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 17),
                        decoration: const InputDecoration(
                            hintText: 'Your Name',
                            hintStyle: TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 17)))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 200, left: 30, right: 30),
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context, 'back'),
                        child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF8C503),
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color(0xFF707070),
                                      blurRadius: 2,
                                      spreadRadius: 0.0,
                                      offset: Offset(0, 1))
                                ]),
                            alignment: Alignment.center,
                            child: const Text('Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)))))
              ]))),
    );
  }
}
