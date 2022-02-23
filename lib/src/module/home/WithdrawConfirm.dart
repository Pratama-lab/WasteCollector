import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class WithdrawConfirmScreen extends StatefulWidget {
  @override
  _WithdrawConfirmState createState() => _WithdrawConfirmState();
}

class _WithdrawConfirmState extends State<WithdrawConfirmScreen> {

  @override
  void initState() {
    super.initState();
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
                          child: Text('Your Available Balance', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('Rp 100.000', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 30.sp),),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 26),
                    width: ScreenUtil().setWidth(430),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(215),
                          alignment: Alignment.centerLeft,
                          child: Text('Enter amount', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                        ),
                        Container(
                          width: ScreenUtil().setHeight(215),
                          child: TouchableOpacity(
                            onTap: () => print('enter all amount'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('images/home/subtraction_2.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text('Enter all amount', style: TextStyle(color: Color(0xFF2AAE1B), fontFamily: 'DiorumCyrillicMedium', fontSize: 16.sp),),
                                )
                              ],
                            )
                          ),
                        ),
                      ]
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: ScreenUtil().setWidth(430),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '100.000',
                        hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic'),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Color(0xFF707070)), borderRadius: BorderRadius.circular(5))
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: ScreenUtil().setWidth(430),
                    child: Text('Send to', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: ScreenUtil().setWidth(430),
                    child: Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(330),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Joko Widodo Sudirjo', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 16.sp),),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text('BCA', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                )
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text('00973538296', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(100),
                          alignment: Alignment.centerRight,
                          child: TouchableOpacity(
                            onTap: () => print('cancel'),
                            child: Container(
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setHeight(30),
                              decoration: BoxDecoration(
                                color: Color(0xFF707070),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(
                                child: Image.asset('images/home/union_84.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 150),
                    child: TouchableOpacity(
                      onTap: () => print('withdraw'),
                      child: Container(
                        width: ScreenUtil().setWidth(430),
                        height: ScreenUtil().setHeight(70),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8C503),
                          borderRadius: BorderRadius.circular(16.7),
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                        ),
                        child: Center(
                          child: Text('Withdraw', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}