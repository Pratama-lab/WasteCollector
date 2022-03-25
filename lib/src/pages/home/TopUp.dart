// ignore_for_file: use_key_in_widget_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_renaming_method_parameters, file_names, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'TopUpConfirm.dart';

class TopUp extends StatefulWidget {
  @override
  TopUpState createState() => TopUpState();
}

class TopUpState extends State<TopUp> {
  String? val_tf_bank;
  List tf_bank = ['BCA', 'BRI', 'Mandiri', 'BNI', 'Permata Bank', 'CIMB Niaga', 'Danamon'];

  @override
  Widget build(BuildContext) {
    return ScreenUtilInit(
      designSize: const Size(480, 956),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8C503),
          title: Text('TopUp', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, 'back'),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: ScreenUtil().setWidth(480),
            alignment: Alignment.topCenter,
            child: Container(
              width: ScreenUtil().setWidth(430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text('Top Up Trough', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text('Transfer Bank', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)),
                    value: val_tf_bank,
                    items: tf_bank.map((value) {
                      return DropdownMenuItem(
                        child: Text(value, style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                        value: value,
                      );
                    }).toList(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF707070)),
                    onChanged: (value) {
                      setState(() {
                        val_tf_bank = value as String?;
                      });
                    }
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text('Transfer with $val_tf_bank', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                  ),

                  const Padding(padding: EdgeInsets.only(top: 100)),
                  Container(
                    width: ScreenUtil().setWidth(430),
                    height: ScreenUtil().setHeight(80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), primary: const Color(0xFFF8C503)),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TopUpConfirm())),
                      child: Text('Continue', style: TextStyle( color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp ),)
                    )
                  )
                ],
              )
            )
          ),
        ),
      )
    );
  }
}