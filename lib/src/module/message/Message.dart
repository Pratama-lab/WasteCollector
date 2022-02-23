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
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(230.1),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.cover)),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.7),
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
                                          gradient: index == 0 ? LinearGradient(
                                            colors: [ Color(0xFFF8C503), Color(0xFFFFE067) ]
                                          ) : null,
                                          boxShadow: [BoxShadow(color: index == 0 ? Colors.grey : Colors.transparent, blurRadius: index == 0 ? 2 : 0, spreadRadius: 0.0, offset: Offset(0, 1))]
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
                                          gradient: index == 1 ? LinearGradient(
                                            colors: [ Color(0xFFF8C503), Color(0xFFFFE067) ]
                                          ) : null,
                                          boxShadow: [BoxShadow(color: index == 1 ? Colors.grey : Colors.transparent, blurRadius: index == 1 ? 2 : 0, spreadRadius: 0.0, offset: Offset(0, 1))]
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
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    child: Container(
                      width: ScreenUtil().setWidth(430),
                      height: ScreenUtil().setHeight(540),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Container(
                              width: ScreenUtil().setWidth(425),
                              height: ScreenUtil().setHeight(116),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                            )
                          )
                        ],
                      )
                    )
                  )
                ] else if (index == 1) ...[
                  Container(
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    child: Container(
                      width: ScreenUtil().setWidth(430),
                      height: ScreenUtil().setHeight(540),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Container(
                              width: ScreenUtil().setWidth(425),
                              height: ScreenUtil().setHeight(116),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                            )
                          );
                        },
                        itemCount: 6,
                      )
                    )
                  )
                ]
              ],
            ),
          )
        )
      ));
  }
}