// ignore_for_file: file_names, use_key_in_widget_constructors, unused_field, unused_element, avoid_print, sized_box_for_whitespace, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_init_to_null, library_private_types_in_public_api, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'HelpCentre.dart';
import 'ShareFeedback.dart';
import 'EditProfile.dart';
import 'package:waste_collection/src/Splash.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic token_local = null;

  @override
  void initState() {
    super.initState();
    ApiGetHomeData().getData();
    if (mounted) {
      setState(() {});
    }
    check_token();
  }

  check_token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    setState(() {
      token_local = token;
    });
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final logOut = await http.post(Uri.parse(API.API_URL + API.logout),
        headers: {'Authorization': 'Bearer $token'});
    Map<String, dynamic> bodyJson = jsonDecode(logOut.body);
    if (bodyJson['message'] == 'success') {
      await prefs.clear();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      if (kDebugMode) {
        print(bodyJson);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
          width: MediaQuery.of(context).size.width,
          height: 230.1,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
          child: Container(
              padding: const EdgeInsets.only(top: 50),
              child: const Text('My Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22)))),
      Container(
          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: 350,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.7),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 0.0,
                    offset: Offset(0, 1))
              ]),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 13),
                    child: FutureBuilder(
                        future: ApiGetHomeData().getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          var profile = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: profile.data.image == null
                                            ? Image.asset(
                                                'images/home/ellipse_302.png',
                                                width: 70)
                                            : Image.network(
                                                '${API.API_URL}storage/profile-images/${profile.data.image}',
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover)),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        width: 200,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('${profile.data.fullName}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16)),
                                              Text('${profile.data.phone}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16)),
                                              Text('${profile.data.email}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16))
                                            ]))
                                  ]),
                                  GestureDetector(
                                      onTap: () async {
                                        if (profile.data.image == null) {
                                          const imageURL = null;
                                          final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileScreen(
                                                        image: imageURL,
                                                        name: profile
                                                            ?.data.fullName,
                                                        phone:
                                                            profile?.data.phone,
                                                        email:
                                                            profile?.data.email,
                                                      )));
                                          if (result == 'back') {
                                            await ApiGetHomeData().getData();
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        } else {
                                          final imageURL = API.API_URL +
                                              'storage/profile-images/' +
                                              profile?.data.image;
                                          final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileScreen(
                                                        image: imageURL,
                                                        name: profile
                                                            ?.data.fullName,
                                                        phone:
                                                            profile?.data.phone,
                                                        email:
                                                            profile?.data.email,
                                                      )));
                                          if (result == 'back') {
                                            await ApiGetHomeData().getData();
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        }
                                      },
                                      child: const Icon(Icons.edit_rounded,
                                          color: Color(0xFFF8C503)))
                                ]);
                          }
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  child: const LoadingIndicator(
                                      indicatorType:
                                          Indicator.ballSpinFadeLoader,
                                      colors: [Color(0xFFF8C503)],
                                      backgroundColor: Colors.transparent)));
                        })),

                Container(
                    padding: const EdgeInsets.only(top: 40, bottom: 22),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HelpCentreScreen())),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Help Centre',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFF707070))
                            ]))),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: const Color(0xFFDEDEDE)))),

                // Container(
                //   padding: const EdgeInsets.only(top: 18, bottom: 22),
                //   child: GestureDetector(
                //     child: Row(
                //       children: [
                //         Container(
                //           width: 360,
                //           child: Align(
                //             alignment: Alignment.centerLeft,
                //             child: Text('Setting', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18),),
                //           ),
                //         ),
                //         Container(
                //           width: 20,
                //           child: Align(
                //             alignment: Alignment.centerRight,
                //             child: Image.asset('images/profile/union_68.png', width: 15), height: 15),,
                //           ),
                //         )
                //       ]
                //     ),
                //   )
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1.0, color: Color(0xFFDEDEDE))
                //   ),
                // ),

                Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ShareFeedbackScreen())),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Share Feedback',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFF707070))
                            ]))),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: const Color(0xFFDEDEDE)))),

                Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                    child: GestureDetector(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                          Text('Privacy Policy',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF707070))
                        ]))),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: const Color(0xFFDEDEDE)))),

                Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                    child: GestureDetector(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                          Text('Terms of Service',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF707070))
                        ]))),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: const Color(0xFFDEDEDE)))),

                Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                    child: GestureDetector(
                        onTap: () {
                          showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 1,
                                    backgroundColor: Colors.white,
                                    insetPadding: const EdgeInsets.all(0),
                                    child: Container(
                                        width: 370,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 38),
                                                  child: Image.asset(
                                                      'images/profile/group_1718.png',
                                                      width: 300)),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14, bottom: 19),
                                                  child: const Text(
                                                      'Do you enjoy using JunkBee?',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18))),
                                              Container(
                                                  width: 300,
                                                  height: 60,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          primary: const Color(
                                                              0xFFF8C503)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();

                                                        showAnimatedDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                (BuildContext) {
                                                              return Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16)),
                                                                  elevation: 1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                          width:
                                                                              370,
                                                                          child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Container(padding: const EdgeInsets.only(top: 38), child: Image.asset('images/profile/group_1734.png', width: 300)),
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                                                                  child: const Text('Amazing!', style: TextStyle(color: Color(0xFFF8C503), fontWeight: FontWeight.w700, fontSize: 20)),
                                                                                ),
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(bottom: 19),
                                                                                  width: 350,
                                                                                  child: const Text('We are happy to hear that you love using JunkBee App! Would you like to share your experience by rating us on the App Store?', style: TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.w400, fontSize: 16), textAlign: TextAlign.center),
                                                                                ),
                                                                                Container(width: 300, height: 60, child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), primary: const Color(0xFFF8C503)), onPressed: () => Navigator.of(context).pop(), child: const Text('Give Rating', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)))),
                                                                                const Padding(padding: EdgeInsets.only(bottom: 15)),
                                                                                GestureDetector(onTap: () => Navigator.of(context).pop(), child: Container(width: 300, height: 60, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(10)), child: const Text('No, Thanks', style: TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.w500, fontSize: 18)))),
                                                                                const Padding(padding: EdgeInsets.only(bottom: 30))
                                                                              ])));
                                                            },
                                                            animationType:
                                                                DialogTransitionType
                                                                    .slideFromTopFade,
                                                            curve: Curves
                                                                .fastOutSlowIn,
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        1));
                                                      },
                                                      child: const Text(
                                                          'Yup, Love It!',
                                                          style:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      18)))),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15)),
                                              GestureDetector(
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Container(
                                                      width: 300,
                                                      height: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFF1F1F1),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      child: const Text(
                                                          'Not Really',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF707070),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18)))),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 30))
                                            ])));
                              },
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(seconds: 1));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Rate us',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFF707070))
                            ]))),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: const Color(0xFFDEDEDE)))),

                Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 22),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('About App',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          Text('v 1.0',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16))
                        ]))
              ])),
      Container(
          padding: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
          child: GestureDetector(
              onTap: () {
                showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 1,
                          backgroundColor: Colors.white,
                          insetPadding: const EdgeInsets.all(0),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: 370,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(),
                                              GestureDetector(
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Image.asset(
                                                      'images/profile/group_2210.png',
                                                      width: 20))
                                            ])),
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 18, bottom: 15),
                                        child: const Text('Comeback Soon!',
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20))),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 45),
                                        child: const Text(
                                            'Are you sure you want to log out?',
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18))),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Container(
                                                  width: 170,
                                                  height: 60,
                                                  alignment: Alignment.center,
                                                  child: const Text('Back',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20)))),
                                          Container(
                                              width: 170,
                                              height: 60,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      primary: const Color(
                                                          0xFFF8C503)),
                                                  onPressed: () => signOut(),
                                                  child: const Text('Confirm',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 20))))
                                        ]),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 30))
                                  ])));
                    },
                    animationType: DialogTransitionType.slideFromBottomFade,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 1));
              },
              child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8C503),
                      borderRadius: BorderRadius.circular(16.7),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 0.0,
                            offset: Offset(0, 1))
                      ]),
                  alignment: Alignment.center,
                  child: const Text('Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20)))))
    ])));
  }
}
