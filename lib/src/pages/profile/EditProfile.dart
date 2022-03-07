import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '25252535526-4gpd2tsihutsru9sd2rujsp0gd65u6mn.apps.googleusercontent.com'
);

class EditProfileScreen extends StatefulWidget {
  final dynamic image;
  final String? name;
  final String? phone;
  final String? email;
  EditProfileScreen({ this.image, this.name, this.phone, this.email});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  bool loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isSwitchedFB = false;
  bool isSwitchedGoogle = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    ApiGetProfileData().getData();
    if (widget.name != null || widget.phone != null || widget.email != null) {
      name.text = widget.name!;
      phoneNumber.text = widget.phone!;
      email.text = widget.email!;
    }
  }

  void takePhoto() async {
    if (await Permission.camera.request().isGranted) {
      var status = await Permission.camera.status;
      if (status.isGranted) {
        print('access granted');
        var photo = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 500.0, maxHeight: 500.0);
        if (photo != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');

          String filename = photo.path.split('/').last;
          String typeImage = photo.name.split('.').last;
          final mimeTypeData = lookupMimeType(photo.path, headerBytes: [0xFF, 0xD8]);
          final request = await http.MultipartRequest('POST', Uri.parse(API.API_URL+API.updateProfileImage));
          final file = await http.MultipartFile.fromPath('image', photo.path, contentType: MediaType('image', typeImage));
          request.files.add(file);
          request.fields['oldImage'] = widget.image;
          request.headers['Authorization'] = 'Bearer ${token}';
          
          try {
            final streamedResponse = await request.send();
            final response = await http.Response.fromStream(streamedResponse);
            Map<String, dynamic> responseJSON = jsonDecode(response.body);
            print(responseJSON);
          } catch (e) {
            print(e);
          }
        }
      } else {
        print('access denied');
      }
    }
  }

  void updateData() async {
    setState(() => loading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(API.API_URL+API.update),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
      body: json.encode({ 'full_name': name.text, 'phone': phoneNumber.text, 'email': email.text, 'address': 'Karleemouth, NM 64927-7156' })
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      setState(() => loading = false);
      Navigator.pop(context, true);
    }
  }

  _onFacebookSignIn() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final profile = await fb.getUserProfile();
        if (profile != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');

          final response = await http.put(
            Uri.parse(API.API_URL+API.updateSocialMedia),
            headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
            body: json.encode({ 'facebook_id': profile.userId })
          );
          Map<String, dynamic> bodyJSON = jsonDecode(response.body);
          if (bodyJSON['message'] == 'data has been updated') {
            await ApiGetProfileData().getData();
            setState(() {});
          }
        }
        break;
      case FacebookLoginStatus.cancel:
        print('You cancel Facebook login');
        break;
      case FacebookLoginStatus.error:
        print('Facebook login error');
        break;
    }
  }

  _onFacebookSignOut() async {
    final fb = FacebookLogin();
    final res = await fb.logOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(API.API_URL+API.updateSocialMedia),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
      body: json.encode({ 'facebook_id': null })
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetProfileData().getData();
      setState(() {});
    }
  }

  _onGoogleSigninSuccess(GoogleSignInAccount account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(API.API_URL+API.updateSocialMedia),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
      body: json.encode({ 'google_id': account.id })
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetProfileData().getData();
      setState(() {});
    }
  }

  _onGoogleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _onGoogleSigninSuccess(account!);
    } catch (error) {
      print(error);
    }
  }

  _onGoogleSignOut() async {
    _googleSignIn.disconnect();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(API.API_URL+API.updateSocialMedia),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}' },
      body: json.encode({ 'google_id': 'null' })
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetProfileData().getData();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Edit Profile', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          backgroundColor: Color(0xFFF8C503),
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: TouchableOpacity(
                onTap: () => updateData(),
                child: Text('Save', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicMedium', fontSize: 18.sp),)
              )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 33.5),
                    child: Stack(
                      children: [
                        FutureBuilder(
                          future: ApiGetProfileData().getData(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            var editProfile = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.done) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(102),
                                child: Image.network(
                                  '${API.API_URL}storage/profile-images/${editProfile?.data.image}',
                                  width: ScreenUtil().setWidth(102), height: ScreenUtil().setHeight(102),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return const CircularProgressIndicator(strokeWidth: 4, color: Color(0xFFF8C503),);
                          }
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
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
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
                            controller: phoneNumber,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
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
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp)
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        FutureBuilder(
                          future: ApiGetProfileData().getData(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            var editProfile = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Container(
                                child: (editProfile.data.facebookId) == null ?
                                  Transform.rotate(
                                    angle: 3.15,
                                    child: FlutterSwitch(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(40),
                                      inactiveColor: Color(0xFFDEDEDE),
                                      inactiveToggleColor: Color(0xFFF0F0F0),
                                      value: isSwitchedGoogle,
                                      onToggle: (value) => _onFacebookSignIn()
                                    ),
                                  )
                                  :
                                  Transform.rotate(
                                    angle: 3.15,
                                    child: FlutterSwitch(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(40),
                                      activeColor: Color(0xFFC2ECBD),
                                      activeToggleColor: Color(0xFF2AAE1B),
                                      value: !isSwitchedGoogle,
                                      onToggle: (value) => _onFacebookSignOut()
                                    ),
                                  )
                              );
                            }
                            return Container(
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setHeight(40),
                              child: const CircularProgressIndicator(strokeWidth: 4, color: Color(0xFFF8C503),)
                            );
                          }
                        )
                      ],
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24),
                    width: ScreenUtil().setWidth(400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        FutureBuilder(
                          future: ApiGetProfileData().getData(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            var editProfile = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Container(
                                child: (editProfile.data.googleId) == 'null' || (editProfile.data.googleId) == null ?
                                  Transform.rotate(
                                    angle: 3.15,
                                    child: FlutterSwitch(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(40),
                                      inactiveColor: Color(0xFFDEDEDE),
                                      inactiveToggleColor: Color(0xFFF0F0F0),
                                      value: isSwitchedGoogle,
                                      onToggle: (value) => _onGoogleSignIn()
                                    ),
                                  )
                                  :
                                  Transform.rotate(
                                    angle: 3.15,
                                    child: FlutterSwitch(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(40),
                                      activeColor: Color(0xFFC2ECBD),
                                      activeToggleColor: Color(0xFF2AAE1B),
                                      value: !isSwitchedGoogle,
                                      onToggle: (value) => _onGoogleSignOut()
                                    ),
                                  )
                              );
                            } else {
                              return Container(
                                width: ScreenUtil().setWidth(40),
                                height: ScreenUtil().setHeight(40),
                                child: const CircularProgressIndicator(strokeWidth: 4, color: Color(0xFFF8C503),)
                              );
                            }
                          }
                        )
                      ],
                    )
                  )
                ],
              ),

              Container(
                color: Colors.transparent,
                child: (loading) ? Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(853),
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Color(0xFFF8C503),
                  )
                ) : null
              )
            ],
          )
        )
      )
    );
  }
}