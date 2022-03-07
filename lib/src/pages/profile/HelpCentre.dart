import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

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
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(260),
          child: Container(
            width: ScreenUtil().setWidth(480),
            height: ScreenUtil().setHeight(260),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/profile/group_2239.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 35),
                  width: ScreenUtil().setWidth(430),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(40),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TouchableOpacity(
                            onTap: () => Navigator.pop(context, true),
                            child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(15.2), height: ScreenUtil().setHeight(24.2),),
                          )
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(350),
                        alignment: Alignment.center,
                        child: Text('Help Centre', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(40),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 35),
                  width: ScreenUtil().setWidth(430),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(215),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(215),
                              child: Text('Hi Joko,', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 9),
                              width: ScreenUtil().setWidth(215),
                              child: Text('We Are Ready', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp))
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 4),
                              width: ScreenUtil().setWidth(215),
                              child: Text('To Help You', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp))
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(215),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 38),
                  width: ScreenUtil().setWidth(430),
                  child: Container(
                    width: ScreenUtil().setWidth(430),
                    height: ScreenUtil().setHeight(60),
                    decoration: BoxDecoration(
                      color: Color(0xFFDEDEDE),
                      borderRadius: BorderRadius.circular(16.7)
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(40),
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/profile/search_icon.png', width: ScreenUtil().setWidth(22), height: ScreenUtil().setHeight(22),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.5),
                          width: ScreenUtil().setWidth(390),
                          child: TextFormField(
                            style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),
                            decoration: InputDecoration(
                              hintText: 'Search help',
                              hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),
                              border: InputBorder.none
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 29, bottom: 24),
                  width: ScreenUtil().setWidth(430),
                  child: Text('All Topics', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                ),
                Container(
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(400),
                          child: Text('Frequently Asked Questions', style: TextStyle(color: Color(0xFF707070), fontSize: 18.sp),),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(30),
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),)
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  width: ScreenUtil().setWidth(430),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 18),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(400),
                          child: Text('Payment Issue', style: TextStyle(color: Color(0xFF707070), fontSize: 18.sp),),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(30),
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),)
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  width: ScreenUtil().setWidth(430),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 18),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(400),
                          child: Text('About My Account', style: TextStyle(color: Color(0xFF707070), fontSize: 18.sp),),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(30),
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),)
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  width: ScreenUtil().setWidth(430),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 18),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(400),
                          child: Text('App Issue', style: TextStyle(color: Color(0xFF707070), fontSize: 18.sp),),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(30),
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/profile/union_68.png', width: ScreenUtil().setWidth(15), height: ScreenUtil().setHeight(15),)
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  width: ScreenUtil().setWidth(430),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 24, bottom: 23),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Need Help With Your Recent Activity?', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                ),
                Container(
                  width: ScreenUtil().setWidth(430),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 17.7, bottom: 8.5),
                        width: ScreenUtil().setWidth(396),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                        child: Row(
                          children: [
                            Image.asset('images/profile/recycle_icon.png', width: ScreenUtil().setWidth(34), height: ScreenUtil().setHeight(33),),
                            Container(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text('Collection Successfully', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 11, bottom: 16.7),
                        width: ScreenUtil().setWidth(396),
                        child: Row(
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(198),
                              child: Text('09:30 | 11 Jul 2021', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(198),
                              alignment: Alignment.centerRight,
                              child: Text('Collection Nr.: 37432', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 31, bottom: 23),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Find More Help', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                ),
                Container(
                  width: ScreenUtil().setWidth(430),
                  height: ScreenUtil().setHeight(121),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/profile/group_2237.png'), fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(150),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(280),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              width: ScreenUtil().setWidth(280),
                              child: Text('Still Need Help?', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              width: ScreenUtil().setWidth(280),
                              child: Text('Fastest way to get help', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                            ),
                            Container(
                              transform: Matrix4.translationValues(-35.0, 0.0, 0.0),
                              padding: const EdgeInsets.only(top: 10),
                              width: ScreenUtil().setWidth(158),
                              child: TouchableOpacity(
                                child: Container(
                                  width: ScreenUtil().setWidth(158),
                                  height: ScreenUtil().setHeight(35),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text('Chat With Us', style: TextStyle(color: Color(0xFF263238), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 21, bottom: 50),
                  width: ScreenUtil().setWidth(165),
                  child: Row(
                    children: [
                      Text('Or you can', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)),
                      Text(' MAIL US', style: TextStyle(color: Color(0xFFF8C503), fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 18.sp)),
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}