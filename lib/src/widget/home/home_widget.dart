import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/pages/home/Wallet.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.simpleCurrency(locale: 'id_ID');

    return FutureBuilder(
      future: ApiGetHomeData().getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var collector = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 45),
                width: ScreenUtil().setWidth(421.3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TouchableOpacity(
                    onTap: () => print('Profile'),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            '${API.API_URL}storage/profile-images/${collector.data.image}',
                            width: ScreenUtil().setWidth(60), height: ScreenUtil().setHeight(60),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 11.2),
                          width: ScreenUtil().setWidth(360),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${collector?.data.fullName}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillicBold', fontSize: 19.3.sp),),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Collector', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillic', fontSize: 19.3.sp),)
                              )
                            ],
                          )
                        ),
                      ],
                    )
                  )
                )
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                width: ScreenUtil().setWidth(421.3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(221.3),
                        child: TouchableOpacity(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WalletScreen(),)),
                          child: Row(
                            children: [
                              Image.asset('images/home/icon_wallet.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40)),
                              Container(
                                padding: const EdgeInsets.only(left: 11.2),
                                child: Column(
                                  children: [
                                    Text('${format.format(int.parse(collector?.data.balance))}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillicBold', fontSize: 19.3.sp),)
                                  ],
                                )
                              ),
                            ],
                          )
                        )
                      ),
                      Container(
                        width: ScreenUtil().setWidth(200),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('${collector?.data.emailVerifiedAt}', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'DiodrumCyrillic', fontSize: 19.3.sp),)
                        )
                      ),
                    ],
                  )
                )
              ),
            ],
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(480),
            height: ScreenUtil().setHeight(800),
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Colors.white,
              ),
            )
          );
        }
      }
    );
  }
}