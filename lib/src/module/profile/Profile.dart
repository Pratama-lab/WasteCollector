import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/model/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'EditProfile.dart';
import 'HelpCentre.dart';
import 'ShareFeedback.dart';
import '../../Login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<CollectorHomeData> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final profileData = await http.get(
      Uri.parse(API.API_URL + API.get),
      headers: {'Authorization': 'Bearer $token'}
    );
    return CollectorHomeDataFromJson(profileData.body);
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
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var profile = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(480),
                        height: ScreenUtil().setHeight(230.1),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.cover)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                            child: Text('My Account', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 26.sp),),
                          )
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
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(78),
                                          child: Image.network(
                                            '${API.API_URL}storage/profile-images/${profile?.data.image}',
                                            width: ScreenUtil().setWidth(78), height: ScreenUtil().setHeight(78), fit: BoxFit.cover
                                          ),
                                        )
                                      )
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 8),
                                      width: ScreenUtil().setWidth(270),
                                      height: ScreenUtil().setHeight(78),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('${profile?.data.fullName}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('${profile?.data.phone}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('${profile?.data.email}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),)
                                          )
                                        ],
                                      )
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      width: ScreenUtil().setWidth(30),
                                      height: ScreenUtil().setHeight(78),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: TouchableOpacity(
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen())),
                                          child: Image.asset('images/profile/edit_svgrepo_com.png', width: ScreenUtil().setWidth(22), height: ScreenUtil().setHeight(22),),
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 50, bottom: 22),
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
                        padding: const EdgeInsets.only(bottom: 30),
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
                  );
                } else {
                  return Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(800),
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Color(0xFFF8C503),
                      ),
                    )
                  );
                }
              }
            )
          ),
        )
      )
    );
  }
}