import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import './DetailCollector.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => new _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  final input = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(230.1),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/heading.png'), fit: BoxFit.cover)),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.7),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text('Input Collection', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      )
                    ),
                  ),

                  Container(
                    transform: Matrix4.translationValues(0.0, -45.0, 0.0),
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(290),
                    child: Image.asset('images/input/confirmed_bro_1.png'),
                  ),

                  Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    child: Center(
                      child: Text('Input Collection Number', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 4),
                    width: ScreenUtil().setWidth(387.3),
                    height: ScreenUtil().setHeight(70),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(16.7)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '12345',
                        border: InputBorder.none,
                      ),
                      controller: input,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    width: ScreenUtil().setWidth(392),
                    child: TouchableOpacity(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCollectionScreen(),)),
                      child: Container(
                        height: ScreenUtil().setHeight(70),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8C503),
                          borderRadius: BorderRadius.circular(16.7)
                        ),
                        child: Center(
                          child: Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                        )
                      )
                    ),
                  )
                ],
              ),
            ),
          )
        )
      ));
  }
}