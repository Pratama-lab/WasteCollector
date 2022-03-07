import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'Withdraw.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                width: ScreenUtil().setWidth(480),
                height: ScreenUtil().setHeight(250),
                decoration: BoxDecoration(
                  color: Color(0xFFF8C503),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                ),
                child: Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(250),
                  decoration: BoxDecoration(
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
                                  onTap: () => Navigator.pop(context),
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

                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('Rp 150.000', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicSemiBold', fontSize: 30.sp),),
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
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                ),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(110),
                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)))),
                      child: TouchableOpacity(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WithdrawScreen(),)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/home/group_885.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                            Container(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text('Withdraw', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 17.sp),),
                            )
                          ],
                        ),
                      )
                    ),
                    Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(110),
                      decoration: BoxDecoration(border: Border(left: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)))),
                      child: TouchableOpacity(
                        onTap: () => print('topup'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/home/group_886.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                            Container(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text('Top Up', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 17.sp),),
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
                child: Text('History Transaction', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),),
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
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
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
                                      child: Text('Withdraw', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3.3),
                                      alignment: Alignment.topLeft,
                                      child: Text('To BCA', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3.3),
                                      alignment: Alignment.topLeft,
                                      child: Text('Rp 300.000', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                width: ScreenUtil().setWidth(120),
                                alignment: Alignment.topRight,
                                child: Text('Yesterday', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),)
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