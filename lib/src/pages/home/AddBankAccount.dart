import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AddBankAccountScreen extends StatefulWidget {
  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccountScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('Add Bank Account', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          backgroundColor: Color(0xFFF8C503),
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          )
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Bank Name', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: ScreenUtil().setWidth(430),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'BCA',
                      hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Your Account', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: ScreenUtil().setWidth(430),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Account Number',
                      hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(430),
                  child: Text('Alias', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: ScreenUtil().setWidth(430),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 200),
                  width: ScreenUtil().setWidth(430),
                  child: TouchableOpacity(
                    onTap: () => print('add bank'),
                    child: Container(
                      width: ScreenUtil().setWidth(430),
                      height: ScreenUtil().setHeight(70),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8C503),
                        borderRadius: BorderRadius.circular(16.7),
                        boxShadow: [BoxShadow(color: Color(0xFF707070), blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                      ),
                      child: Center(
                        child: Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),)
                      ),
                    )
                  ),
                )
              ],
            )
          ),
        ),
      )
    );
  }
}