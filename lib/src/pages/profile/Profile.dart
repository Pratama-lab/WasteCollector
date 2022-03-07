import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_collection/src/widget/profile/profile_widget.dart';
import 'HelpCentre.dart';
import 'ShareFeedback.dart';
import 'package:waste_collection/src/Login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    ApiGetProfileData().getData();
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(230.1),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
                  child: Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text('My Account', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 26.sp),),
                  )
                ),

                Container(
                  transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                  width: ScreenUtil().setWidth(421.3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.7),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 13),
                          width: ScreenUtil().setWidth(380),
                          child: ProfileWidget()
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 40, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpCentreScreen(),)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Help Centre', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Setting', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShareFeedbackScreen(),)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Share Feedback', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Privacy Policy', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Terms of Service', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: TouchableOpacity(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(360),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Rate us', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        Container(
                          width: ScreenUtil().setWidth(380),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 22),
                          width: ScreenUtil().setWidth(380),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(280),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('About App', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(100),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('v 1.0', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                ),
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  )
                ),

                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: TouchableOpacity(
                    onTap: () => signOut(),
                    child: Container(
                      width: ScreenUtil().setWidth(380),
                      height: ScreenUtil().setHeight(70),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8C503),
                        borderRadius: BorderRadius.circular(16.7),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                      ),
                      child: Center(
                        child: Text('Sign Out', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp))
                      ),
                    )
                  ),
                )
              ],
            )
          ),
        )
      )
    );
  }
}