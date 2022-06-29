// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print, prefer_final_fields, unused_field, unused_import, library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_collection/src/api/api_server.dart';
import './DetailCollector.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  TextEditingController input = TextEditingController();
  bool _validateText = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // permissionHandler();
  }

  permissionHandler() async {
    if (await Permission.camera.request().isGranted) {
      var status = await Permission.camera.status;
      if (status.isGranted) {
        print('access granted');
      } else {
        print('access denied');
      }
    }
  }

  void collectorDetails() async {
    setState(() => loading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(
      Uri.parse(API.API_URL + API.getCollectorDetail + input.text),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data found' && bodyJSON['data'].length != 0) {
      var resp = await http.get(Uri.parse(API.API_URL + API.getWasteList));
      Map<String, dynamic> JSON = jsonDecode(resp.body);
      if (JSON['message'] == 'exist') {
        setState(() => loading = false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailCollectionScreen(
                image: bodyJSON['data'][0]['driver']['image'] ?? 'null',
                fullName: bodyJSON['data'][0]['driver']['full_name'],
                created: bodyJSON['data'][0]['driver']['created_at'],
                orderCode: bodyJSON['data'][0]['order_code'],
                weight: bodyJSON['data'][0]['total_weight'],
                total: int.parse(bodyJSON['data'][0]['total']),
                feeBeever: int.parse(bodyJSON['data'][0]['fee_beever']),
                urlImages: bodyJSON['data'][0]['url'],
                type: bodyJSON['data'][0]['images'][0]['waste_type'],
                images: bodyJSON['data'][0]['images'],
                pricePaper: JSON['data'][0]['price'],
                priceMixPaper: JSON['data'][0]['price'])));
      }
    } else if (bodyJSON['message'] == 'data found' &&
        bodyJSON['data'].length == 0) {
      setState(() => loading = false);
      Fluttertoast.showToast(
          msg: 'Orderan tidak ditemukan',
          backgroundColor: const Color(0xFFF8C503),
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
            child: Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.topCenter,
                child: const Text('Input Collection',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)))),
        Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                width: 250,
                height: 250,
                child: Image.asset('images/input/confirmed_bro_1.png'))),
        Container(
            transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            alignment: Alignment.center,
            child: const Text('Input Collection Number',
                style: TextStyle(
                    color: Color(0xFF707070),
                    fontWeight: FontWeight.w700,
                    fontSize: 22))),
        Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
                decoration: InputDecoration(
                    hintText: '12345',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.7),
                        borderSide: const BorderSide(color: Color(0xFFF8C503))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.7),
                        borderSide: const BorderSide(
                            color: Color(0xFFDEDEDE), width: 2.0)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.7),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.7),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0)),
                    errorText:
                        (_validateText) ? 'Input text cannot be empty' : null),
                controller: input)),
        Container(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: GestureDetector(
                onTap: () {
                  if (input.text.isEmpty) {
                    setState(() {
                      _validateText = true;
                    });
                  } else {
                    setState(() {
                      _validateText = false;
                    });
                    collectorDetails();
                  }
                },
                child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8C503),
                        borderRadius: BorderRadius.circular(16.7)),
                    alignment: Alignment.center,
                    child: const Text('Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20)))))
      ]),
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
