import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:waste_collection/src/api/api_server.dart';
import './DetailCollector.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  final input = TextEditingController();
  bool _validateText = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void collectorDetails() async {
    setState(() => loading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(
      Uri.parse(API.API_URL+API.getCollectorDetail+input.text),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' },
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data found') {
      setState(() => loading = false);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCollectionScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(480),
                      height: ScreenUtil().setHeight(240),
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
                      child: Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('Input Collection', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                        )
                      ),
                    ),

                    Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      width: ScreenUtil().setWidth(290),
                      height: ScreenUtil().setHeight(290),
                      child: Image.asset('images/input/confirmed_bro_1.png'),
                    ),

                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: Center(
                        child: Text('Input Collection Number', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(387.3),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: InputDecoration(
                          hintText: '12345',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.7),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.7),
                            borderSide: const BorderSide(
                              color: Color(0xFFDEDEDE),
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.7),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.7),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          counterText: '',
                          errorText: (_validateText) ? 'Input text cannot be empty' : null
                        ),
                        controller: input,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      width: ScreenUtil().setWidth(392),
                      child: TouchableOpacity(
                        onTap: () {
                          if (input.text.isEmpty) {
                            setState(() {
                              _validateText = true;
                            });
                          } else {
                            setState(() {
                              _validateText = false;
                            });
                            collectorDetails();
                          }
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(70),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8C503),
                            borderRadius: BorderRadius.circular(16.7)
                          ),
                          child: Center(
                            child: Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                          )
                        )
                      ),
                    )
                  ],
                ),

                Container(
                  color: Colors.transparent,
                  child: (loading) ? Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(904),
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    alignment: Alignment.center,
                    child: Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(105),
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
          ),
        )
      ));
  }
}