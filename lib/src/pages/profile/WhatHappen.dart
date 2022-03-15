import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class WhatHappen extends StatefulWidget {
  const WhatHappen({Key? key}) : super(key: key);
  @override
  _WhatHappenState createState() => _WhatHappenState();
}

class _WhatHappenState extends State<WhatHappen> {
  List<String> what_happen = ['Something wrong with this order', 'About fee transaction', 'Others.'];

  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF8C503),
          title: Text('What Happening?', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: ScreenUtil().setWidth(480),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: what_happen.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: ScreenUtil().setWidth(480),
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: ScreenUtil().setWidth(435),
                        child: Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) => print(value)),
                            Container(
                              child: Text(what_happen[index], style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)),
                            )
                          ],
                        ),
                      )
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: ScreenUtil().setWidth(400),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFDEDEDE)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      width: ScreenUtil().setWidth(380),
                      child: TextFormField(
                        style: TextStyle( color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),
                          hintText: 'Describe your reason',
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 100, bottom: 50),
                  child: TouchableOpacity(
                    onTap: () => print('submit'),
                    child: Container(
                      width: ScreenUtil().setWidth(222),
                      height: ScreenUtil().setHeight(65),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8C503),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                      ),
                      alignment: Alignment.center,
                      child: Text('Submit', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp)),
                    )
                  )
                )
              ],
            ),
          )
        ),
      )
    );
  }
}