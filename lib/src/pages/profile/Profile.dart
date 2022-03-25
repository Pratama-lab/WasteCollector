// ignore_for_file: file_names, use_key_in_widget_constructors, unused_field, unused_element, avoid_print, sized_box_for_whitespace, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
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
                                                      child: Text('${profile?.data.fullName}', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text('${profile?.data.phone}', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text('${profile?.data.email}', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),)
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
                                              child: Text('Help Centre', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                                      border: Border.all(width: 1.0, color: const Color(0xFFDEDEDE))
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
                                              child: Text('Share Feedback', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                                      border: Border.all(width: 1.0, color: const Color(0xFFDEDEDE))
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
                                              child: Text('Privacy Policy', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                                      border: Border.all(width: 1.0, color: const Color(0xFFDEDEDE))
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
                                              child: Text('Terms of Service', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                                      border: Border.all(width: 1.0, color: const Color(0xFFDEDEDE))
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                                    width: ScreenUtil().setWidth(380),
                                    child: TouchableOpacity(
                                      onTap: () {
                                        showAnimatedDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              elevation: 1,
                                              backgroundColor: Colors.white,
                                              insetPadding: const EdgeInsets.all(0),
                                              child: Container(
                                                width: ScreenUtil().setWidth(400),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 38),
                                                      child: Image.asset('images/profile/group_1718.png', width: ScreenUtil().setWidth(300))
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 14, bottom: 19),
                                                      child: Text('Do you enjoy using JunkBee?', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp)),
                                                    ),

                                                    Container(
                                                      width: ScreenUtil().setWidth(300),
                                                      height: ScreenUtil().setHeight(60),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), primary: const Color(0xFFF8C503)),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();

                                                          showAnimatedDialog(
                                                            context: context,
                                                            barrierDismissible: true,
                                                            builder: (BuildContext) {
                                                              return Dialog(
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                                elevation: 1,
                                                                backgroundColor: Colors.white,
                                                                insetPadding: const EdgeInsets.all(0),
                                                                child: Container(
                                                                  width: ScreenUtil().setWidth(400),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Container(
                                                                        padding: const EdgeInsets.only(top: 38),
                                                                        child: Image.asset('images/profile/group_1734.png', width: ScreenUtil().setWidth(300))
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                                                                        child: Text('Amazing!', style: TextStyle(color: const Color(0xFFF8C503), fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp)),
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.only(bottom: 19),
                                                                        width: ScreenUtil().setWidth(350),
                                                                        child: Text(
                                                                          'We are happy to hear that you love using JunkBee App! Would you like to share your experience by rating us on the App Store?',
                                                                          style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp), textAlign: TextAlign.center
                                                                        ),
                                                                      ),

                                                                      Container(
                                                                        width: ScreenUtil().setWidth(300),
                                                                        height: ScreenUtil().setHeight(60),
                                                                        child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), primary: const Color(0xFFF8C503)),
                                                                          onPressed: () => Navigator.of(context).pop(),
                                                                          child: Text('Give Rating', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp ),)
                                                                        ),
                                                                      ),
                                                                      const Padding(padding: EdgeInsets.only(bottom: 15)),
                                                                      GestureDetector(
                                                                        onTap: () => Navigator.of(context).pop(),
                                                                        child: Container(
                                                                          width: ScreenUtil().setWidth(300),
                                                                          height: ScreenUtil().setHeight(60),
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color: const Color(0xFFF1F1F1),
                                                                            borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: Text('No, Thanks', style: TextStyle( color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 20.sp ),)
                                                                        )
                                                                      ),
                                                                      const Padding(padding: EdgeInsets.only(bottom: 30))
                                                                    ],
                                                                  )
                                                                )
                                                              );
                                                            },
                                                            animationType: DialogTransitionType.slideFromTopFade,
                                                            curve: Curves.fastOutSlowIn,
                                                            duration: const Duration(seconds: 1)
                                                          );
                                                        },
                                                        child: Text('Yup, Love It!', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp ),)
                                                      ),
                                                    ),
                                                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                                                    GestureDetector(
                                                      onTap: () => Navigator.of(context).pop(),
                                                      child: Container(
                                                        width: ScreenUtil().setWidth(300),
                                                        height: ScreenUtil().setHeight(60),
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFF1F1F1),
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Text('Not Really', style: TextStyle( color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 20.sp ),)
                                                      )
                                                    ),
                                                    const Padding(padding: EdgeInsets.only(bottom: 30))
                                                  ],
                                                )
                                              )
                                            );
                                          },
                                          animationType: DialogTransitionType.slideFromBottomFade,
                                          curve: Curves.fastOutSlowIn,
                                          duration: const Duration(seconds: 1)
                                        );
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(360),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Rate us', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                                      border: Border.all(width: 1.0, color: const Color(0xFFDEDEDE))
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
                                            child: Text('About App', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                          ),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(100),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('v 1.0', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
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
                              onTap: () {
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      insetPadding: const EdgeInsets.all(0),
                                      child: Container(
                                        width: ScreenUtil().setWidth(420),
                                        height: ScreenUtil().setHeight(320),
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: ScreenUtil().setWidth(380),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(top: 5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(),
                                                    GestureDetector(
                                                      onTap: () => Navigator.of(context).pop(),
                                                      child: Image.asset('images/profile/group_2210.png', width: ScreenUtil().setWidth(20),)
                                                    )
                                                  ],
                                                )
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(top: 18, bottom: 15),
                                                child: Text('Comeback Soon!', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp)),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(bottom: 45),
                                                child: Text(
                                                  'Are you sure you want to log out?',
                                                  style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp)
                                                ),
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Navigator.of(context).pop(),
                                                    child: Container(
                                                      width: ScreenUtil().setWidth(190),
                                                      height: ScreenUtil().setHeight(60),
                                                      alignment: Alignment.center,
                                                      child: Text('Back', style: TextStyle( color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 20.sp ),)
                                                    )
                                                  ),
                                                  Container(
                                                    width: ScreenUtil().setWidth(190),
                                                    height: ScreenUtil().setHeight(60),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), primary: const Color(0xFFF8C503)),
                                                      onPressed: () => signOut(),
                                                      child: Text('Confirm', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp ),)
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Padding(padding: EdgeInsets.only(bottom: 30))
                                            ],
                                          )
                                        )
                                      )
                                    );
                                  },
                                  animationType: DialogTransitionType.slideFromBottomFade,
                                  curve: Curves.fastOutSlowIn,
                                  duration: const Duration(seconds: 1)
                                );
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(380),
                                height: ScreenUtil().setHeight(70),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8C503),
                                  borderRadius: BorderRadius.circular(16.7),
                                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
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
          ],
        )
      )
    );
  }
}
