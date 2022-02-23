import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/model/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

EditProfileData EditProfileDataFromJson(String str) =>
    EditProfileData.fromJson(jsonDecode(str));

String EditProfileDataToJson(EditProfileData data) => json.encode(data.toJson());

class EditProfileData {
  final int? success;
  final String? message;
  final Data? data;

  EditProfileData({
    this.success,
    this.message,
    this.data,
  });

  factory EditProfileData.fromJson(Map<String, dynamic> json) => EditProfileData(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? email;
  final String? fullName;
  final String? phone;
  final dynamic image;
  final dynamic googleId;
  final dynamic facebookId;

  Data({
    this.email,
    this.fullName,
    this.phone,
    this.image,
    this.googleId,
    this.facebookId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json['email'],
    fullName: json["full_name"],
    phone: json["phone"],
    image: json["image"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "full_name": fullName,
    "phone": phone,
    "image": image,
    "google_id": googleId,
    "facebook_id": facebookId,
  };
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isSwitchedFB = false;
  bool isSwitchedGoogle = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<EditProfileData> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final editProfile = await http.get(
      Uri.parse(API.API_URL + API.get),
      headers: {'Authorization': 'Bearer $token'}
    );
    return EditProfileDataFromJson(editProfile.body);
  }

  void takePhoto() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print('access granted');
      var photo = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 500.0, maxHeight: 500.0);
      if (photo != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');

        final editProfile = await http.get(
          Uri.parse(API.API_URL + API.get),
          headers: {'Authorization': 'Bearer $token'}
        );
        var response = json.decode(editProfile.body);

        String fileName = photo.path.split('/').last;
        FormData formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(photo.path, filename:fileName, contentType: new MediaType('image', photo.name.split('.').last)),
          // 'oldImage': await MultipartFile.fromFile(API.API_URL+'storage/profile-images/'+response['data']['image'], filename: response['data']['image'])
        });
        await Dio().post('https://staging2.junkbee.id/api/userdata/update/image', data: formData)
        .then((response) => print(response))
        .catchError((error) => print(error));
      }
      // uploadImage();
    } else {
      print('access denied');
    }
  }

  void updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(API.API_URL+API.update),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
      body: json.encode({ 'full_name': 'Miss Ellisa Jacobi', 'phone': '089124378248', 'email': 'darkangle33@gmail.com', 'address': 'Karleemouth, NM 64927-7156' })
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    print(bodyJSON['message']);
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
                            onTap: () => Navigator.pop(context, true),
                            child: Image.asset('images/group_2211.png', width: ScreenUtil().setWidth(15.2), height: ScreenUtil().setHeight(24.2),),
                          )
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(350),
                        alignment: Alignment.center,
                        child: Text('Edit Profile', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(40),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TouchableOpacity(
                            onTap: () => updateData(),
                            child: Text('Save', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),),
                          )
                        ),
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
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var editProfile = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 33.5),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(102),
                                child: Image.network(
                                  '${API.API_URL}storage/profile-images/${editProfile.data.image}',
                                  width: ScreenUtil().setWidth(102.7), height: ScreenUtil().setHeight(102),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: TouchableOpacity(
                                  onTap: () => takePhoto(),
                                  child: Container(
                                    width: ScreenUtil().setWidth(35),
                                    height: ScreenUtil().setHeight(35),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8C503),
                                      borderRadius: BorderRadius.circular(35)
                                    ),
                                    child: Center(
                                      child: Image.asset('images/profile/group_1666.png', width: ScreenUtil().setWidth(17), height: ScreenUtil().setHeight(17),),
                                    ),
                                  )
                                )
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 48.7),
                          width: ScreenUtil().setWidth(350),
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(341.6),
                                child: Text('Your Name', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(341.6),
                                child: TextFormField(
                                  controller: name,
                                  decoration: InputDecoration(
                                    hintText: '${editProfile.data.fullName}',
                                    hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                                  ),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 24),
                                width: ScreenUtil().setWidth(341.6),
                                child: Text('Mobile Number', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(341.6),
                                child: TextFormField(
                                  // controller: phoneNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '${editProfile.data.phone}',
                                    hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                                  ),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 24),
                                width: ScreenUtil().setWidth(341.6),
                                child: Text('Email Address', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(341.6),
                                child: TextFormField(
                                  // controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: '${editProfile.data.email}',
                                    hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 41),
                          width: ScreenUtil().setWidth(400),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Linked Account', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),)
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 24),
                          width: ScreenUtil().setWidth(400),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(200),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Image.asset('images/profile/group_1669.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Facebook', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                      )
                                    ],
                                  )
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(200),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Transform.rotate(
                                    angle: 3.15,
                                    child: CupertinoSwitch(
                                      activeColor: Color(0xFFC2ECBD),
                                      thumbColor: Color(0xFF2AAE1B),
                                      value: isSwitchedFB,
                                      onChanged: (value) => setState(() => isSwitchedFB = value)
                                    ),
                                  )
                                ),
                              )
                            ],
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 24),
                          width: ScreenUtil().setWidth(400),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(200),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Image.asset('images/profile/group_1670.png', width: ScreenUtil().setWidth(40), height: ScreenUtil().setHeight(40),),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Google', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                      )
                                    ],
                                  )
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(200),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Transform.rotate(
                                    angle: 3.15,
                                    child: CupertinoSwitch(
                                      activeColor: Color(0xFFC2ECBD),
                                      thumbColor: Color(0xFF2AAE1B),
                                      value: isSwitchedGoogle,
                                      onChanged: (value) => setState(() => isSwitchedGoogle = value)
                                    ),
                                  )
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    );
                  }
                  return Container(
                    width: ScreenUtil().setWidth(480),
                    height: ScreenUtil().setHeight(800),
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Color(0xFFF8C503),
                      ),
                    )
                  );
                }
              )
            )
          )
        )
      )
    );
  }
}