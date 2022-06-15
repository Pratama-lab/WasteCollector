// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_field, avoid_print, await_only_futures, unused_local_variable, unnecessary_brace_in_string_interps, sized_box_for_whitespace, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/api/api_server.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '25252535526-4gpd2tsihutsru9sd2rujsp0gd65u6mn.apps.googleusercontent.com');

class EditProfileScreen extends StatefulWidget {
  final dynamic image;
  final String? name;
  final String? phone;
  final String? email;
  EditProfileScreen({this.image, this.name, this.phone, this.email});

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
    if (mounted) {
      ApiGetHomeData().getData();
    }
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
        var photo = await ImagePicker().pickImage(
            source: ImageSource.camera, maxWidth: 500.0, maxHeight: 500.0);
        if (photo != null) {
          setState(() {
            loading = true;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');

          String typeImage = photo.name.split('.').last;
          final request = await http.MultipartRequest(
              'POST', Uri.parse(API.API_URL + API.updateProfileImage));
          final file = await http.MultipartFile.fromPath('image', photo.path,
              contentType: MediaType('image', typeImage));
          request.files.add(file);
          if (widget.image == null) {
            request.fields['oldImage'] = '';
          } else {
            request.fields['oldImage'] = widget.image;
          }
          request.headers['Authorization'] = 'Bearer ${token}';

          try {
            final streamedResponse = await request.send();
            final response = await http.Response.fromStream(streamedResponse);
            Map<String, dynamic> responseJSON = jsonDecode(response.body);
            if (responseJSON['message'] == 'data has been updated') {
              setState(() {
                loading = false;
              });
              Navigator.pop(context, 'back');
            }
          } catch (e) {
            setState(() {
              loading = false;
            });
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

    final response = await http.put(Uri.parse(API.API_URL + API.update),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode({
          'full_name': name.text,
          'phone': phoneNumber.text,
          'email': email.text,
          'address': 'Karleemouth, NM 64927-7156'
        }));
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      setState(() => loading = false);
      Navigator.pop(context, 'back');
    }
  }

  _onFacebookSignIn() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [FacebookPermission.publicProfile]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final profile = await fb.getUserProfile();
        if (profile != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');

          final response = await http.put(
              Uri.parse(API.API_URL + API.updateSocialMedia),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${token}'
              },
              body: json.encode({'facebook_id': profile.userId}));
          Map<String, dynamic> bodyJSON = jsonDecode(response.body);
          if (bodyJSON['message'] == 'data has been updated') {
            await ApiGetHomeData().getData();
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
        Uri.parse(API.API_URL + API.updateSocialMedia),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode({'facebook_id': null}));
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetHomeData().getData();
      setState(() {});
    }
  }

  _onGoogleSigninSuccess(GoogleSignInAccount account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(
        Uri.parse(API.API_URL + API.updateSocialMedia),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode({'google_id': account.id}));
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetHomeData().getData();
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
        Uri.parse(API.API_URL + API.updateSocialMedia),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode({'google_id': 'null'}));
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data has been updated') {
      await ApiGetHomeData().getData();
      setState(() {});
    }
  }

  _onWillPop() async {
    Navigator.pop(context, 'back');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
                title: const Text('Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)),
                centerTitle: true,
                backgroundColor: const Color(0xFFF8C503),
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context, 'back'),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white)),
                actions: [
                  Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () => updateData(),
                          child: const Text('Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18))))
                ]),
            body: Stack(fit: StackFit.expand, children: [
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 33.5),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(102),
                                child: widget.image == null
                                    ? Image.asset('images/home/ellipse_302.png',
                                        width: 100)
                                    : Image.network(widget.image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover)),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                    onTap: () => takePhoto(),
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF8C503),
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Center(
                                            child: Image.asset(
                                                'images/profile/group_1666.png',
                                                width: 17,
                                                height: 17)))))
                          ])),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 48.7, left: 30, right: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Your Name',
                                    style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                TextFormField(
                                    controller: name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                const Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Text('Mobile Number',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                ),
                                TextFormField(
                                    controller: phoneNumber,
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                const Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Text('Email Address',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                ),
                                TextFormField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))
                              ])),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 41, left: 20, right: 20),
                          child: const Text('Linked Account',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18))),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 24, left: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset('images/profile/group_1669.png',
                                      width: 40, height: 40),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Facebook',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18)))
                                ]),
                                FutureBuilder(
                                    future: ApiGetHomeData().getData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      var editProfile = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                            child: (editProfile
                                                        .data.facebookId) ==
                                                    null
                                                ? Transform.rotate(
                                                    angle: 3.15,
                                                    child: FlutterSwitch(
                                                        width: 70,
                                                        height: 40,
                                                        inactiveColor:
                                                            const Color(
                                                                0xFFDEDEDE),
                                                        inactiveToggleColor:
                                                            const Color(
                                                                0xFFF0F0F0),
                                                        value: isSwitchedGoogle,
                                                        onToggle: (value) =>
                                                            _onFacebookSignIn()))
                                                : Transform.rotate(
                                                    angle: 3.15,
                                                    child: FlutterSwitch(
                                                        width: 70,
                                                        height: 40,
                                                        activeColor:
                                                            const Color(
                                                                0xFFC2ECBD),
                                                        activeToggleColor:
                                                            const Color(
                                                                0xFF2AAE1B),
                                                        value:
                                                            !isSwitchedGoogle,
                                                        onToggle: (value) =>
                                                            _onFacebookSignOut())));
                                      }
                                      return Container(
                                          width: 40,
                                          height: 40,
                                          child: const LoadingIndicator(
                                              indicatorType:
                                                  Indicator.ballSpinFadeLoader,
                                              colors: [Color(0xFFF8C503)],
                                              backgroundColor:
                                                  Colors.transparent));
                                    })
                              ])),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 24, left: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset('images/profile/group_1670.png',
                                      width: 40, height: 40),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Google',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18)))
                                ]),
                                FutureBuilder(
                                    future: ApiGetHomeData().getData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      var editProfile = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                            child: (editProfile.data.googleId) ==
                                                        'null' ||
                                                    (editProfile.data.googleId) ==
                                                        null
                                                ? Transform.rotate(
                                                    angle: 3.15,
                                                    child: FlutterSwitch(
                                                        width: 70,
                                                        height: 40,
                                                        inactiveColor:
                                                            const Color(
                                                                0xFFDEDEDE),
                                                        inactiveToggleColor:
                                                            const Color(
                                                                0xFFF0F0F0),
                                                        value: isSwitchedGoogle,
                                                        onToggle: (value) =>
                                                            _onGoogleSignIn()))
                                                : Transform.rotate(
                                                    angle: 3.15,
                                                    child: FlutterSwitch(
                                                        width: 70,
                                                        height: 40,
                                                        activeColor: const Color(
                                                            0xFFC2ECBD),
                                                        activeToggleColor:
                                                            const Color(0xFF2AAE1B),
                                                        value: !isSwitchedGoogle,
                                                        onToggle: (value) => _onGoogleSignOut())));
                                      } else {
                                        return Container(
                                            width: 40,
                                            height: 40,
                                            child: const LoadingIndicator(
                                                indicatorType: Indicator
                                                    .ballSpinFadeLoader,
                                                colors: [Color(0xFFF8C503)],
                                                backgroundColor:
                                                    Colors.transparent));
                                      }
                                    })
                              ]))
                    ]),
              ),
              (loading)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      alignment: Alignment.center,
                      child: Container(
                          width: 100,
                          height: 105,
                          child: const LoadingIndicator(
                              indicatorType: Indicator.lineSpinFadeLoader,
                              colors: [Color(0xFFF8C503)],
                              backgroundColor: Colors.transparent)))
                  : Container()
            ])));
  }
}
