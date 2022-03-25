// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_new, sized_box_for_whitespace, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => new _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int index = 0;
  final List<String> chat = <String>['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(480),
                height: ScreenUtil().setHeight(280),
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text('Message', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.only(top: 22.7),
                          width: ScreenUtil().setWidth(350),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(175),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TouchableOpacity(
                                    onTap: () => setState(() => index = 0),
                                    child: Container(
                                      width: ScreenUtil().setWidth(144.7),
                                      height: ScreenUtil().setHeight(70.7),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: index == 0 ? 0.0 : 1.0, color: index == 0 ? Colors.transparent : Colors.white),
                                        borderRadius: BorderRadius.circular(16.7),
                                        gradient: index == 0 ? const LinearGradient(
                                          colors: [ const Color(0xFFF8C503), Color(0xFFFFE067) ]
                                        ) : null,
                                        boxShadow: [BoxShadow(color: index == 0 ? Colors.grey : Colors.transparent, blurRadius: index == 0 ? 2 : 0, spreadRadius: 0.0, offset: const Offset(0, 1))]
                                      ),
                                      child: Center(
                                        child: Text('Chat', style: TextStyle(color: Colors.white, fontFamily: index == 0 ? 'DiodrumCyrillicBold' : 'DiodrumCyrillic', fontSize: 20.sp),),
                                      ),
                                    )
                                  ),
                                )
                              ),

                              Container(
                                width: ScreenUtil().setWidth(175),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TouchableOpacity(
                                    onTap: () => setState(() => index = 1),
                                    child: Container(
                                      width: ScreenUtil().setWidth(144.7),
                                      height: ScreenUtil().setHeight(70.7),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: index == 1 ? 0.0 : 1.0, color: index == 1 ? Colors.transparent : Colors.white),
                                        borderRadius: BorderRadius.circular(16.7),
                                        gradient: index == 1 ? const LinearGradient(
                                          colors: [ Color(0xFFF8C503), const Color(0xFFFFE067) ]
                                        ) : null,
                                        boxShadow: [BoxShadow(color: index == 1 ? Colors.grey : Colors.transparent, blurRadius: index == 1 ? 2 : 0, spreadRadius: 0.0, offset: const Offset(0, 1))]
                                      ),
                                      child: Center(
                                        child: Text('Inbox', style: TextStyle(color: Colors.white, fontFamily: index == 1 ? 'DiodrumCyrillicBold' : 'DiodrumCyrillic', fontSize: 20.sp),),
                                      ),
                                    )
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  )
                ),
              ),

              if (index == 0) ...[
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(600),
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              width: ScreenUtil().setWidth(430),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                              child: Container(
                                width: ScreenUtil().setWidth(400),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(60),
                                      height: ScreenUtil().setHeight(60),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8C503),
                                        borderRadius: BorderRadius.circular(60)
                                      ),
                                      child: Image.asset('images/message/chat_svgrepo.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),)
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: ScreenUtil().setWidth(240),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Feedback', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                          Text('Rate your order experience!', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                          Text('How many star would you give', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp), maxLines: 1,),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(100),
                                      alignment: Alignment.topRight,
                                      child: Text('Yesterday', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                    )
                                  ],
                                ),
                              )
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        );
                      }
                    )
                  )
                )
              ] else if (index == 1) ...[
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(600),
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              width: ScreenUtil().setWidth(430),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                              child: Container(
                                width: ScreenUtil().setWidth(400),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(60),
                                      height: ScreenUtil().setHeight(60),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(60)
                                      ),
                                      child: Image.asset('images/message/tag_svgrepo.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),)
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: ScreenUtil().setWidth(240),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Offer', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                          Text('10% Discount Picking Up Your Order', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp), maxLines: 1,),
                                          Text('Get your discount now!', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp), maxLines: 1,),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(100),
                                      alignment: Alignment.topRight,
                                      child: Text('Yesterday', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                    )
                                  ],
                                ),
                              )
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        );
                      }
                    )
                  )
                )
              ]
            ],
          ),
        )
      ));
  }
}