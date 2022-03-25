// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'Withdraw.dart';
import 'TopUp.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');

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
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                width: ScreenUtil().setWidth(480),
                height: ScreenUtil().setHeight(250),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8C503),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                ),
                child: Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(250),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/home/mask_group_31.png'))
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 35),
                          width: ScreenUtil().setWidth(430),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(30),
                                alignment: Alignment.topLeft,
                                child: TouchableOpacity(
                                  onTap: () => Navigator.pop(context, 'back'),
                                  child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(15.2), height: ScreenUtil().setHeight(24.2),)
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(370),
                                alignment: Alignment.topCenter,
                                child: Text('Wallet', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(30),
                              )
                            ],
                          )
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: ScreenUtil().setWidth(144),
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: [
                              Image.asset('images/home/icon_wallet.png', width: ScreenUtil().setWidth(35), height: ScreenUtil().setHeight(35),),
                              Container(
                                padding: const EdgeInsets.only(left: 10.8),
                                child: Text('Your Cash', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                              )
                            ],
                          )
                        ),

                        FutureBuilder(
                          future: ApiGetHomeData().getData(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            var saldo = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Container(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text('${format.format(int.parse(saldo?.data.balance))}', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 30.sp),),
                              );
                            }
                            return Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(20),
                                child: const LoadingIndicator(
                                  strokeWidth: 1,
                                  indicatorType: Indicator.ballPulse,
                                  colors: [Colors.white],
                                  backgroundColor: Colors.transparent
                                )
                              ),
                            );
                          }
                        )
                      ],
                    )
                  )
                )
              ),

              Container(
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(110),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                ),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(110),
                      decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)))),
                      child: TouchableOpacity(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WithdrawScreen(),)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/home/group_885.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                            Container(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text('Withdraw', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 17.sp),),
                            )
                          ],
                        ),
                      )
                    ),
                    Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(110),
                      decoration: const BoxDecoration(border: Border(left: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)))),
                      child: TouchableOpacity(
                        onTap: () async {
                          var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TopUp()));
                          if (result == 'back') {
                            await ApiGetHomeData().getData();
                            setState(() {});
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/home/group_886.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                            Container(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text('Top Up', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 17.sp),),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),

              Container(
                width: ScreenUtil().setWidth(400),
                child: Text('History Transaction', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(490.8),
                child: Container(
                  width: ScreenUtil().setWidth(400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                  ),
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: ScreenUtil().setWidth(370),
                    child: ListView.separated(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          width: ScreenUtil().setWidth(370),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(250),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Withdraw', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3.3),
                                      alignment: Alignment.topLeft,
                                      child: Text('To BCA', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3.3),
                                      alignment: Alignment.topLeft,
                                      child: Text('Rp 300.000', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                width: ScreenUtil().setWidth(120),
                                alignment: Alignment.topRight,
                                child: Text('Yesterday', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),)
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, index) => const Divider()
                    ),
                  )
                )
              )
            ],
          ),
        )
      )
    );
  }
}