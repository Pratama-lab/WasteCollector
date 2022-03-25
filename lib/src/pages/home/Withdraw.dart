// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, non_constant_identifier_names, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'WithdrawConfirm.dart';
import 'AddBankAccount.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<WithdrawScreen> {
  bool ovoClicked = false;
  bool danaClicked = false;

  @override
  void initState() {
    super.initState();
  }

  void ovo_clicked() {
    if (ovoClicked = !ovoClicked) {
      setState(() {
        ovoClicked = true;
      });
    } else {
      setState(() {
        ovoClicked = false;
      });
    }
  }

  void dana_clicked() {
    if (danaClicked = !danaClicked) {
      setState(() {
        danaClicked = true;
      });
    } else {
      setState(() {
        danaClicked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('Withdraw', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          backgroundColor: const Color(0xFFF8C503),
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          )
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/home/wallet_svgrepo_com.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                      Container(
                        padding: const EdgeInsets.only(left: 9),
                        child: Text('Your Total Balance', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: ApiGetHomeData().getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var saldo = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('Rp 150.000', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 30.sp),),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(20),
                        child: const LoadingIndicator(
                          strokeWidth: 1,
                          indicatorType: Indicator.ballPulse,
                          colors: [Color(0xFFF8C503)],
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    );
                  }
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Available for Withdraw', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                      Text(' Rp 100.000', style: TextStyle(color: const Color(0xFF2AAE1B), fontFamily: 'DiodrumCyrillicMedium', fontSize: 16.sp),),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Choose your bank account', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBankAccountScreen(),)),
                    child: Row(
                      children: [
                        Image.asset('images/home/subtraction_2.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text('Add Bank Account', style: TextStyle(color: const Color(0xFF2AAE1B), fontFamily: 'DiodrumCyrillicMedium', fontSize: 16.sp),),
                        )
                      ],
                    )
                  )
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Or choose virtual account', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 17),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    onTap: () => ovo_clicked(),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(330),
                          alignment: Alignment.centerLeft,
                          child: Image.asset('images/home/logo_ovo_pay.png', width: ScreenUtil().setWidth(90), height: ScreenUtil().setHeight(50),),
                        ),
                        Container(
                          width: ScreenUtil().setHeight(100),
                          alignment: Alignment.centerRight,
                          child: (ovoClicked) ?
                            Container(width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25), decoration: BoxDecoration(border: Border.all(width: 1.0, color: const Color(0xFF707070)), borderRadius: BorderRadius.circular(25)),)
                            :
                            Image.asset('images/input/group_2201.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                        )
                      ],
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  width: ScreenUtil().setWidth(430),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 17),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    onTap: () => dana_clicked(),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(330),
                          alignment: Alignment.centerLeft,
                          child: Image.asset('images/home/rectangle_1869.png', width: ScreenUtil().setWidth(90), height: ScreenUtil().setHeight(50),),
                        ),
                        Container(
                          width: ScreenUtil().setHeight(100),
                          alignment: Alignment.centerRight,
                          child: (danaClicked) ?
                            Container(width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25), decoration: BoxDecoration(border: Border.all(width: 1.0, color: const Color(0xFF707070)), borderRadius: BorderRadius.circular(25)),)
                            :
                            Image.asset('images/input/group_2201.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                        )
                      ],
                    ),
                  )
                ),

                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: TouchableOpacity(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WithdrawConfirmScreen(),)),
                    child: Container(
                      width: ScreenUtil().setWidth(430),
                      height: ScreenUtil().setHeight(70),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8C503),
                        borderRadius: BorderRadius.circular(16.7),
                        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                      ),
                      child: Center(
                        child: Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                      ),
                    )
                  ),
                )
              ]
            ),
          )
        ),
      )
    );
  }
}