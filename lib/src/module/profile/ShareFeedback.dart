import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

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
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(260),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/profile/mask_group_30.png'), fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: ScreenUtil().setWidth(430),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(40),
                                alignment: Alignment.centerLeft,
                                child: TouchableOpacity(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(15.2), height: ScreenUtil().setHeight(24.2),),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(350),
                                alignment: Alignment.center,
                                child: Text('Share Feedback', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(40),
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 25),
                          width: ScreenUtil().setWidth(210),
                          child: Text('Every Feeadback helps. What can we improve on?', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 18.sp), textAlign: TextAlign.center,),
                        )
                      ],
                    )
                  ),

                  Container(
                    transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3.0, color: Color(0xFF2AAE1B))
                    ),
                    child: Center(
                      child: Image.asset('images/profile/volunteering_bro_1.png', width: ScreenUtil().setWidth(150), height: ScreenUtil().setHeight(150),),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    child: Text('Waste Collector', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 18.sp),),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    width: ScreenUtil().setWidth(400),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Color(0xFFDEDEDE),
                      borderRadius: BorderRadius.circular(16.7)
                    ),
                    child: Container(
                      width: ScreenUtil().setWidth(380),
                      child: TextFormField(
                        style: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),
                          hintText: 'Tell us your thought',
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: TouchableOpacity(
                      onTap: () => print('send feedback'),
                      child: Container(
                        width: ScreenUtil().setWidth(380),
                        height: ScreenUtil().setHeight(70),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8C503),
                          borderRadius: BorderRadius.circular(16.7),
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                        ),
                        child: Center(
                          child: Text('Send Feedback', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 21.sp))
                        ),
                      )
                    )
                  )
                ],
              ),
            )
          )
        ),
      )
    );
  }
}