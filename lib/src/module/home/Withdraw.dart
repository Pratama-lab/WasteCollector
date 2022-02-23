import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
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
      designSize: Size(480, 904),
      builder: () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: Container(
              height: ScreenUtil().setHeight(72),
              decoration: BoxDecoration(
                color: Color(0xFFF8C503),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
              ),
              child: Center(
                child: Container(
                  width: ScreenUtil().setWidth(430),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(40),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TouchableOpacity(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(15.2), height: ScreenUtil().setHeight(24.2),),
                          )
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(350),
                        alignment: Alignment.center,
                        child: Text('Withdraw', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(40),
                      )
                    ],
                  ),
                ),
              )
            ),
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
                          child: Text('Your Total Balance', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('Rp 150.000', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 30.sp),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Available for Withdraw', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                        Text(' Rp 100.000', style: TextStyle(color: Color(0xFF2AAE1B), fontFamily: 'DiodrumCyrillicMedium', fontSize: 16.sp),),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: ScreenUtil().setWidth(430),
                    child: Text('Choose your bank account', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
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
                            child: Text('Add Bank Account', style: TextStyle(color: Color(0xFF2AAE1B), fontFamily: 'DiodrumCyrillicMedium', fontSize: 16.sp),),
                          )
                        ],
                      )
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: ScreenUtil().setWidth(430),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: ScreenUtil().setWidth(430),
                    child: Text('Or choose virtual account', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
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
                              Container(width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25), decoration: BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFF707070)), borderRadius: BorderRadius.circular(25)),)
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
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFDEDEDE)))),
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
                              Container(width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25), decoration: BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFF707070)), borderRadius: BorderRadius.circular(25)),)
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
                          color: Color(0xFFF8C503),
                          borderRadius: BorderRadius.circular(16.7),
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
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
      )
    );
  }
}