import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/widget/home/home_widget.dart';
import 'CollectionReceived.dart';
import 'History.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    super.initState();
    ApiGetHomeData().getData();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(280),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: ScreenUtil().setWidth(421.3),
                      child: HomeWidget()
                    )
                  ),
                ),

                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  width: ScreenUtil().setWidth(421.3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.7),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 15.3, left: 12.7),
                            child: Row(
                              children: [
                                Text('Upcoming Collection', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                                Container(
                                  padding: const EdgeInsets.only(left: 14.7),
                                  child: Text('- Today', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                ),
                              ],
                            )
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 17.3, right: 12.7),
                            child: Image.asset('images/home/group_2188.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 12.5),
                        width: ScreenUtil().setWidth(389.7),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE),))
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(389.7),
                        height: ScreenUtil().setHeight(200),
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 15),
                          shrinkWrap: true,
                          itemCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              width: ScreenUtil().setWidth(389.7),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: ScreenUtil().setWidth(200.3),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('On Going by Sunaryo #2375', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('8:53 AM - Collection Point Mangkang', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(89.4),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text('5 Kg', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text('Est Weight', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(100),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text('Rp 4.000', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text('Est Price', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          )
                                        )
                                      ],
                                    )
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider()
                        )
                      ),
                    ],
                  ),
                ),

                Container(
                  transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                  child: TouchableOpacity(
                    onTap: () => print('move to input screen'),
                    child: Container(
                      width: ScreenUtil().setWidth(421.3),
                      height: ScreenUtil().setHeight(70.3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.7),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15.4),
                            child: Row(
                              children: [
                                Image.asset('images/home/group_2183.png', width: ScreenUtil().setWidth(35), height: ScreenUtil().setHeight(35), color: Color(0xFFF8C503),),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.8),
                                  child: Text('Input Collection Number', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),)
                                ),
                              ],
                            )
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 15.4),
                            child: Container(
                              width: ScreenUtil().setWidth(45),
                              height: ScreenUtil().setHeight(45),
                              decoration: BoxDecoration(
                                color: Color(0xFFF8C503),
                                borderRadius: BorderRadius.circular(45)
                              ),
                              child: Center(
                                child: Image.asset('images/home/group_1633.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  width: ScreenUtil().setWidth(421.3),
                  child: Text('Quick Links', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 22, bottom: 100),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 28),
                        child: TouchableOpacity(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CollectionReceivedScreen(),)),
                          child: Container(
                            width: ScreenUtil().setWidth(160.7),
                            height: ScreenUtil().setHeight(120.3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.7),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 6, left: 10),
                                      child: Text('1200', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Image.asset('images/home/group_2184.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 9.3, left: 10),
                                  child: Text('Collection Received', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 11.67),
                                  child: Container(
                                    width: ScreenUtil().setWidth(155),
                                    height: ScreenUtil().setHeight(10),
                                    child: Image.asset('images/home/subtraction_27.png'),
                                  )
                                )
                              ]
                            ),
                          )
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 14),
                        child: TouchableOpacity(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryScreen(),)),
                          child: Container(
                            width: ScreenUtil().setWidth(160.7),
                            height: ScreenUtil().setHeight(120.3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.7),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 6, left: 10),
                                      child: Text('100', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Image.asset('images/home/group_2184.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 9.3, left: 10),
                                  child: Text('History Transaction', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 11.67),
                                  child: Container(
                                    width: ScreenUtil().setWidth(155),
                                    height: ScreenUtil().setHeight(10),
                                    child: Image.asset('images/home/subtraction_26.png'),
                                  )
                                )
                              ]
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          )
        )
      )
    );
  }
}
