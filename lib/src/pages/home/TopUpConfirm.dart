// ignore_for_file: file_names, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_renaming_method_parameters, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopUpConfirm extends StatefulWidget {
  const TopUpConfirm({Key? key}) : super(key: key);
  
  @override
  TopUpConfirmState createState() => TopUpConfirmState();
}

class TopUpConfirmState extends State<TopUpConfirm> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext) {
    final key = GlobalKey<ScaffoldState>();
    return ScreenUtilInit(
      designSize: const Size(480, 956),
      builder: () => Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8C503),
          title: Text('Top Up', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          )
        ),
        body: Container(
          width: ScreenUtil().setWidth(480),
          height: ScreenUtil().setHeight(956),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(80),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                    ),
                    child: Container(
                      width: ScreenUtil().setWidth(420),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Biaya Admin', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                          Text('${format.format(int.parse('5000'))}', style: TextStyle(color: const Color(0xFFF30000), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                        ],
                      ),
                    )
                  ),
                  const Padding(padding: EdgeInsets.only(top: 7)),
                  Container(
                    width: ScreenUtil().setWidth(480),
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                    ),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 22)),
                        Container(
                          width: ScreenUtil().setWidth(420),
                          child: Row(
                            children: [
                              Image.asset('images/home/bank_central_asia.png', width: ScreenUtil().setWidth(75),),
                              Container(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text('Bank BCA (Dicek Otomatis)', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),)
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          width: ScreenUtil().setWidth(420),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: const Color(0xFFDEDEDE)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          width: ScreenUtil().setWidth(420),
                          child: Text('No. Rekening', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                        ),
                        Container(
                          width: ScreenUtil().setWidth(420),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('0221 81234567890', style: TextStyle(color: const Color(0xFFF30000), fontFamily: 'DiodrumCyrillicMedium', fontSize: 24.sp),),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(text: '022181234567890'));
                                  // ignore: prefer_const_constructors
                                  key.currentState!.showSnackBar(SnackBar(content: Text("Copied to Clipboard")));
                                },
                                child: Text('Salin', style: TextStyle(color: const Color(0xFF88D1F0), fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),)
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          width: ScreenUtil().setWidth(420),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: const Color(0xFFDEDEDE)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          width: ScreenUtil().setWidth(420),
                          child: Text(
                            'Transfer pembayaran Top Up Anda melalui Virtual Account dari Bank BCA',
                            style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  width: ScreenUtil().setWidth(480),
                  alignment: Alignment.center,
                  child: Container(
                    width: ScreenUtil().setWidth(420),
                    height: ScreenUtil().setHeight(80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), primary: const Color(0xFFF8C503)),
                      onPressed: () => print('ok'),
                      child: Text('Ok', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp ),)
                    )
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