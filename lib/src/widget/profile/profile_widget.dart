import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/pages/profile/EditProfile.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiGetProfileData().getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var profile = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(80),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(78),
                    child: Image.network(
                      '${API.API_URL}storage/profile-images/${profile?.data.image}',
                      width: ScreenUtil().setWidth(78), height: ScreenUtil().setHeight(78), fit: BoxFit.cover
                    ),
                  )
                )
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                width: ScreenUtil().setWidth(270),
                height: ScreenUtil().setHeight(78),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${profile?.data.fullName}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${profile?.data.phone}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${profile?.data.email}', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),)
                    )
                  ],
                )
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                width: ScreenUtil().setWidth(30),
                height: ScreenUtil().setHeight(78),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TouchableOpacity(
                    onTap: () {
                      final imageURL = API.API_URL+'storage/profile-images/'+profile?.data.image;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen(image: imageURL, name: profile?.data.fullName, phone: profile?.data.phone, email: profile?.data.email,)));
                    },
                    child: Image.asset('images/profile/edit_svgrepo_com.png', width: ScreenUtil().setWidth(22), height: ScreenUtil().setHeight(22),),
                  )
                ),
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            color: Color(0xFFF8C503),
          )
        );
      }
    );
  }
}