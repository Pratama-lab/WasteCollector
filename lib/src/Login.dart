import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:waste_collection/src/api/api_server.dart';
import './navigation/Navigator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
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
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAegOfRbMJBr2nLkk6vyNH2W-JhSpRX_Sg',
        appId: '1:25252535526:android:750cf338056ecf55b16f27',
        messagingSenderId: '25252535526',
        projectId: 'waste-collection-d96a1'
      )
    );
    FirebaseMessaging.instance.getToken()
    .then((deviceToken) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(
        Uri.parse(API.API_URL+API.login),
        headers: { 'Content-Type': 'application/json' },
        body: json.encode({ 'email': email.text, 'password': password.text })
      );
      Map<String, dynamic> bodyJSON = jsonDecode(response.body);
      
      if (bodyJSON['message'] == 'login success') {
        prefs.setString('token', bodyJSON['data']['token']);

        final resp = await http.put(
          Uri.parse(API.API_URL+API.updateDeviceToken),
          headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${bodyJSON['data']['token']}' },
          body: json.encode({ 'device_token': deviceToken })
        );
        Map<String, dynamic> tokenJSON = jsonDecode(resp.body);
        if (tokenJSON['message'] == 'data has been updated') {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Navigation()));
        }
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
    return ScreenUtilInit(
      designSize: Size(480, 853.3),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Center(
                      child: Image.asset('images/main_logo.png', width: 196.1, height: 147.8,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Waste Collector', style: TextStyle(color: Color(0xFFF8C503), fontFamily: 'DiodrumCyrillicBold', fontSize: 25.sp),),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: ScreenUtil().setWidth(386.3),
                    child: Center(
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp ),
                          labelText: 'Email',
                          errorText: (_validateEmail) ? 'Email cannot be empty' : null
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.6),
                    width: ScreenUtil().setWidth(386.3),
                    child: TextFormField(
                      controller: password,
                      obscureText: _obsecureText,
                      style: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp ),
                        labelText: 'Password',
                        errorText: (_validatePassword) ? 'Password cannot be empty' : null,
                        suffixIcon: IconButton(
                          onPressed: () => toogle(),
                          icon: Icon((_obsecureText) ? Icons.visibility_off : Icons.visibility)
                        )
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 18.8),
                    width: ScreenUtil().setWidth(386.3),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TouchableOpacity(
                        child: Text('Forgot Password?', style: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp ),)
                      ),
                    )
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 46),
                    width: ScreenUtil().setWidth(388.7),
                    height: ScreenUtil().setHeight(64.7),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), primary: Color(0xFFF8C503)),
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
                            loading = true;
                          });
                          signIn();
                        }
                      },
                      child: Text('Sign In', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 21.3.sp ),)
                    ),
                  )
                ],
              ),

              Container(
                color: Colors.transparent,
                child: (loading) ?  Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(853.3),
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  alignment: Alignment.center,
                  child: Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(100),
                    child: const LoadingIndicator(
                      indicatorType: Indicator.lineSpinFadeLoader,
                      colors: [Color(0xFFF8C503)],
                      backgroundColor: Colors.transparent,
                    )
                  )
                ) : null
              )
            ],
          )
        )
      ),
    );
  }
}