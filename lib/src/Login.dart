// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_collection/src/api/api_server.dart';
import './navigation/Navigator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _obsecureText = true;

  @override
  void initState() {
    super.initState();
  }

  void signIn() async {
    setState(() => loading = true);
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((deviceToken) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(Uri.parse(API.API_URL + API.login),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email.text, 'password': password.text}));
      Map<String, dynamic> bodyJSON = jsonDecode(response.body);

      if (bodyJSON['message'] == 'login success' &&
          bodyJSON['data']['role'] == 'waste collector') {
        prefs.setString('token', bodyJSON['data']['token']);

        final resp =
            await http.put(Uri.parse(API.API_URL + API.updateDeviceToken),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ${bodyJSON['data']['token']}'
                },
                body: json.encode({'device_token': deviceToken}));
        Map<String, dynamic> tokenJSON = jsonDecode(resp.body);
        if (tokenJSON['message'] == 'data has been updated') {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Navigation()));
        } else {
          setState(() => loading = false);
          Fluttertoast.showToast(
              msg: 'Login Gagal \nSilahkan login kembali',
              backgroundColor: const Color(0xFFF8c503),
              fontSize: 18,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT);
        }
      } else {
        setState(() => loading = false);
        Fluttertoast.showToast(
            msg:
                'Anda bukan Waste Collector \nSilahkan login dengan akun Waste Collector',
            backgroundColor: const Color(0xFFF8c503),
            fontSize: 18,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
  }

  void toogle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 70),
            child: Center(
                child: Image.asset('images/main_logo.png',
                    width: 196, height: 147))),
        const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Waste Collector',
                style: TextStyle(
                    color: Color(0xFFF8C503),
                    fontWeight: FontWeight.w700,
                    fontSize: 20))),
        Container(
            margin: const EdgeInsets.only(right: 35, left: 35),
            child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: Center(
                    child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                            labelText: 'Email',
                            errorText: (_validateEmail)
                                ? 'Email cannot be empty'
                                : null))))),
        Container(
            margin: const EdgeInsets.only(right: 35, left: 35),
            child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                    controller: password,
                    obscureText: _obsecureText,
                    style: const TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                        labelText: 'Password',
                        errorText: (_validatePassword)
                            ? 'Password cannot be empty'
                            : null,
                        suffixIcon: IconButton(
                            onPressed: () => toogle(),
                            icon: Icon((_obsecureText)
                                ? Icons.visibility_off
                                : Icons.visibility)))))),
        Container(
            margin: const EdgeInsets.only(right: 35, left: 35),
            child: Container(
                margin: const EdgeInsets.only(top: 18.8),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ))))),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Container(
              margin: const EdgeInsets.only(top: 46),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      primary: const Color(0xFFF8C503)),
                  onPressed: () {
                    if (email.text.isEmpty) {
                      setState(() {
                        _validateEmail = true;
                      });
                    } else if (password.text.isEmpty) {
                      setState(() {
                        _validatePassword = true;
                      });
                    } else {
                      setState(() {
                        _validateEmail = false;
                        _validatePassword = false;
                      });
                      signIn();
                    }
                  },
                  child: const Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22)))),
        )
      ]),
      Container(
          color: Colors.transparent,
          child: (loading)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  alignment: Alignment.center,
                  child: Container(
                      width: 100,
                      height: 100,
                      child: const LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [Color(0xFFF8C503)],
                          backgroundColor: Colors.transparent)))
              : null)
    ])));
  }
}
