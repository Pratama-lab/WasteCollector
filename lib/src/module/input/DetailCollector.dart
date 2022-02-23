import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DetailCollectionScreen extends StatefulWidget {
  @override
  _DetailCollectionState createState() => new _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollectionScreen> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => new Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(90),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8C503),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 27.8),
                        child: TouchableOpacity(
                          onTap:() => Navigator.pop(context),
                          child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),)
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 78),
                        child: Text('Input Collection', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      )
                    ],
                  )
                ),

                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            width: ScreenUtil().setWidth(417.3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.7),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset('images/input/beever.png', width: ScreenUtil().setWidth(85), height: ScreenUtil().setHeight(85),),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(180),
                                            child: Text('Sunaryo', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 21.sp),)
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 5),
                                            width: ScreenUtil().setWidth(180),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset('images/input/group_2191.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                                                Text('4.5 | 20 Points', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                              ],
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(125),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text('03/04/2021', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 5),
                                            width: ScreenUtil().setWidth(125),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text('Verified', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),)
                                            ),
                                          )
                                        ],
                                      )
                                    )
                                  ],
                                ),

                                Container(
                                  width: ScreenUtil().setWidth(386.1),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(top: 15, left: 11),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(180),
                                        child: Text('09.30 | 11 Jul 2021', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(206),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('Collection Nr.: 3749', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                        )
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: ScreenUtil().setWidth(386.1),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                  ),
                                ),

                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      width: ScreenUtil().setWidth(386.1),
                                      child: Text('details of collection', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 21.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 19, bottom: 10),
                                      width: ScreenUtil().setWidth(386.1),
                                      child: Text('Category', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 21.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: ScreenUtil().setWidth(386.1),
                                      height: ScreenUtil().setHeight(65),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Paper', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 21.sp),),
                                      )
                                    ),

                                    Container(
                                      padding: const EdgeInsets.only(top: 35),
                                      width: ScreenUtil().setWidth(386.1),
                                      child: Row(
                                        children: <Widget>[
                                          TouchableOpacity(
                                            onTap: () =>  print('add picture'),
                                            child: Container(
                                              width: ScreenUtil().setWidth(89.4),
                                              height: ScreenUtil().setHeight(90.4),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF8C503),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Center(
                                                child: Image.asset('images/input/group_2196.png', width: ScreenUtil().setWidth(47.8), height: ScreenUtil().setHeight(48.1),),
                                              ),
                                            )
                                          ),

                                          Container(
                                            padding: const EdgeInsets.only(left: 20.7),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset('images/input/botol.jpg', width: ScreenUtil().setWidth(89.4), height: ScreenUtil().setHeight(90.4)),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.only(top: 20, left: 11),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(100),
                                            child: Text('Summary', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(150),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: ScreenUtil().setWidth(110),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      width: ScreenUtil().setWidth(80),
                                                      height: ScreenUtil().setHeight(60),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 1.0),
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(
                                                          labelStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),
                                                          border: InputBorder.none
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenUtil().setWidth(40),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text('kg', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                                  ),
                                                )
                                              ],
                                            )
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(135),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: TouchableOpacity(
                                                onTap: () => print('Pressed'),
                                                child: Container(
                                                  width: ScreenUtil().setWidth(110),
                                                  height: ScreenUtil().setHeight(60),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF8C503),
                                                    borderRadius: BorderRadius.circular(16.7),
                                                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text('Confirm', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                                  ),
                                                )
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: ScreenUtil().setWidth(386.1),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(top: 25, left: 11),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(190),
                                        child: Text('Release to Beever', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(195),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('Rp -', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                        )
                                      )
                                    ],
                                  )
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10, left: 11, bottom: 40),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(190),
                                        child: Text('Release to Customer', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(195),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('Rp -', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                        )
                                      )
                                    ],
                                  )
                                )
                              ],
                            )
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 37.3, bottom: 34.7),
                          child: TouchableOpacity(
                            onTap: () => print('Pressed'),
                            child: Container(
                              width: ScreenUtil().setWidth(392),
                              height: ScreenUtil().setHeight(70),
                              decoration: BoxDecoration(
                                color: Color(0xFFF8C503),
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Received', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                              )
                            )
                          ),
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}