import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'HelpCentre.dart';
import 'ShareFeedback.dart';
import 'EditProfile.dart';
import 'package:waste_collection/src/Login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  String _text = 'Swipe me!';

  @override
  void initState() {
    super.initState();
    ApiGetProfileData().getData();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(controller);
  }

  void _onVerticalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.up) {
        _text = 'Swipe up!';
        print('Swipe up!');
      } else {
        _text = 'Swipe down!';
        print('Swipe down!');
      }
    });
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(904),
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(480),
                            height: ScreenUtil().setHeight(230.1),
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
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
                              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(top: 13),
                                    width: ScreenUtil().setWidth(380),
                                    child: FutureBuilder(
                                      future: ApiGetProfileData().getData(),
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        var profile = snapshot.data;
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return Row(
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
                                                    onTap: () async {
                                                      final imageURL = API.API_URL+'storage/profile-images/'+profile?.data.image;
                                                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(image: imageURL, name: profile?.data.fullName, phone: profile?.data.phone, email: profile?.data.email,)));
                                                      if (result == 'back') {
                                                        await ApiGetHomeData().getData();
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Image.asset('images/profile/edit_svgrepo_com.png', width: ScreenUtil().setWidth(22), height: ScreenUtil().setHeight(22),),
                                                  )
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        return Center(
                                          child: Container(
                                            width: ScreenUtil().setWidth(70),
                                            height: ScreenUtil().setHeight(70),
                                            child: const LoadingIndicator(
                                              indicatorType: Indicator.ballSpinFadeLoader,
                                              colors: [Color(0xFFF8C503)],
                                              backgroundColor: Colors.transparent,
                                            ),
                                          )
                                        );
                                      }
                                    )
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

                                  // Container(
                                  //   padding: const EdgeInsets.only(top: 18, bottom: 22),
                                  //   width: ScreenUtil().setWidth(380),
                                  //   child: TouchableOpacity(
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Container(
                                  //           width: ScreenUtil().setWidth(360),
                                  //           child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text('Setting', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                  //           ),
                                  //         ),
                                  //         Container(
                                  //           width: ScreenUtil().setWidth(20),
                                  //           child: Align(
                                  //             alignment: Alignment.centerRight,
                                  //             child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),),
                                  //           ),
                                  //         )
                                  //       ]
                                  //     ),
                                  //   )
                                  // ),
                                  // Container(
                                  //   width: ScreenUtil().setWidth(380),
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                                  //   ),
                                  // ),

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
                                      onTap: () {
                                        switch (controller.status) {
                                          case AnimationStatus.dismissed:
                                            controller.forward();
                                            break;
                                          default:
                                        }
                                      },
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
              ],
            ),

            //start animation enjoy using junkbee
            Container(
              width: ScreenUtil().setWidth(480),
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: offset,
                child: Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(670),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 2, offset: Offset(0, 1))]
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: TouchableOpacity(
                          onTap: () {
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                controller.reverse();
                                break;
                              default:
                            }
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(150),
                            height: ScreenUtil().setHeight(5),
                            decoration: BoxDecoration(
                              color: Color(0xFFDEDEDE),
                              border: Border.all(width: 1, color: Color(0xFFDEDEDE)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        )
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 10),
                        child: Image.asset('images/profile/group_1718.png', width: ScreenUtil().setWidth(300),),
                      ),
                      Text('Do You enjoy using Junkbee?', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),

                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: TouchableOpacity(
                          onTap: () {
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                controller.reverse();
                                break;
                              default:
                            }
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(350),
                            height: ScreenUtil().setHeight(70),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8C503),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                            ),
                            alignment: Alignment.center,
                            child: Text('Yup, Love It!', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                          )
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: TouchableOpacity(
                          onTap: () {
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                controller.reverse();
                                break;
                              default:
                            }
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(350),
                            height: ScreenUtil().setHeight(70),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Text('Not Really', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),),
                          )
                        ),
                      )
                    ],
                  )
                )
              ),
            )
            //end animation enjoy using junkbee
          ],
        )
      )
    );
  }
}