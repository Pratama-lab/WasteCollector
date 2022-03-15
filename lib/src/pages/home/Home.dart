import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'Wallet.dart';
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
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(280),
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: ScreenUtil().setWidth(421.3),
                      child: FutureBuilder(
                        future: ApiGetHomeData().getData(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          var collector = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 45),
                                  width: ScreenUtil().setWidth(421),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TouchableOpacity(
                                      onTap: () => print('Profile'),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(60),
                                            child: Image.network(
                                              '${API.API_URL}storage/profile-images/${collector.data.image}',
                                              width: ScreenUtil().setWidth(60), height: ScreenUtil().setHeight(60),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 11.2),
                                            width: ScreenUtil().setWidth(360),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text('${collector?.data.fullName}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillicBold', fontSize: 19.3.sp),),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text('Collector', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillic', fontSize: 19.3.sp),)
                                                )
                                              ],
                                            )
                                          ),
                                        ],
                                      )
                                    )
                                  )
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 25),
                                  width: ScreenUtil().setWidth(421.3),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: ScreenUtil().setWidth(221.3),
                                          child: TouchableOpacity(
                                            onTap: () async {
                                              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                                              if (result == 'back') {
                                                await ApiGetHomeData().getData();
                                                setState(() {});
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset('images/home/icon_wallet.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40)),
                                                Container(
                                                  padding: const EdgeInsets.only(left: 11.2),
                                                  child: Column(
                                                    children: [
                                                      Text('${format.format(int.parse(collector?.data.balance))}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillicBold', fontSize: 19.3.sp),)
                                                    ],
                                                  )
                                                ),
                                              ],
                                            )
                                          )
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(200),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('${DateFormat('MMM, d y').format(DateTime.now())}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillic', fontSize: 19.3.sp),)
                                          )
                                        ),
                                      ],
                                    )
                                  )
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              width: ScreenUtil().setWidth(480),
                              height: ScreenUtil().setHeight(800),
                              color: Colors.transparent,
                              child: Center(
                                child: Container(
                                  width: ScreenUtil().setWidth(70),
                                  height: ScreenUtil().setHeight(70),
                                  child: const LoadingIndicator(
                                    indicatorType: Indicator.ballSpinFadeLoader,
                                    colors: [Colors.white],
                                    backgroundColor: Colors.transparent,
                                  ),
                                )
                              )
                            );
                          }
                        }
                      )
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
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryScreen())),
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
