// ignore_for_file: file_names, unused_import, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, must_be_immutable, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';

class DetailCollectionScreen extends StatefulWidget {
  //beever info
  String image = '';
  String fullName = '';
  String created = '';
  //order info
  String orderCode = '';
  String weight = '';
  int total;
  int feeBeever;
  String urlImages = '';
  String type = '';
  List images = [];
  //waste info
  String pricePaper = '';
  String priceMixPaper = '';
  DetailCollectionScreen(
      {Key? key,
      required this.image,
      required this.fullName,
      required this.created,
      required this.orderCode,
      required this.weight,
      required this.total,
      required this.feeBeever,
      required this.urlImages,
      required this.type,
      required this.images,
      required this.pricePaper,
      required this.priceMixPaper})
      : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollectionScreen> {
  TextEditingController weight = TextEditingController();
  final format = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  int total_balance = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      ApiGetDetailCollection().getData(widget.orderCode);
    }
  }

  update_collection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (widget.type == 'Paper') {
      double total =
          (double.parse(weight.text) * double.parse(widget.pricePaper));

      var response = await http.put(
          Uri.parse(
              '${API.API_URL}${API.collectionConfirm}?order_code=${widget.orderCode}&waste_weight=${weight.text}&total_weight=${weight.text}&subtotal=$total&total=$total'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        if (mounted) {
          await ApiGetDetailCollection().getData(widget.orderCode);
          setState(() {});
        }
      } else {
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: const Color(0xFFF8C503),
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            fontSize: 18);
      }
    } else if (widget.type == 'Mix Paper') {
      double total =
          (double.parse(weight.text) * double.parse(widget.priceMixPaper));

      var response = await http.put(
          Uri.parse(
              '${API.API_URL}${API.collectionConfirm}?order_code=${widget.orderCode}&waste_weight=${weight.text}&total_weight=${weight.text}&subtotal=$total&total=$total'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        if (mounted) {
          await ApiGetDetailCollection().getData(widget.orderCode);
          setState(() {});
        }
      } else {
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: const Color(0xFFF8C503),
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            fontSize: 18);
      }
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
            appBar: AppBar(
                title: const Text('Input Collection',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)),
                centerTitle: true,
                backgroundColor: const Color(0xFFF8C503),
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context, 'back'),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white))),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
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
                          child: FutureBuilder(
                              future: ApiGetDetailCollection()
                                  .getData(widget.orderCode),
                              builder: (context, AsyncSnapshot snapshot) {
                                var details = snapshot.data;
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: details.data.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        weight.text =
                                            details.data[index].totalWeight;
                                        //format date driver
                                        String dateTime = details
                                            .data[index].driver.createdAt;
                                        String date = dateTime.substring(
                                            0, dateTime.indexOf('T'));
                                        var inputFormat =
                                            DateFormat('yyyy-MM-dd');
                                        var inputDate = inputFormat.parse(date);
                                        var outputFormat =
                                            DateFormat('dd/MM/yyyy');
                                        var outputDate =
                                            outputFormat.format(inputDate);
                                        //format date collection
                                        String dateTimeColl =
                                            details.data[index].createdAt;
                                        String dateColl =
                                            dateTimeColl.substring(
                                                0, dateTime.indexOf('T'));
                                        String timeColl =
                                            dateTimeColl.substring(
                                                dateTimeColl.indexOf('T') + 1);
                                        String secondColl = timeColl.substring(
                                            0, timeColl.indexOf('Z'));
                                        var intlDateColl = Jiffy(DateTime.parse(
                                                '$dateColl $secondColl'))
                                            .format("d MMM yyyy");
                                        //format time collection
                                        var inputFormatSecond =
                                            DateFormat('HH:mm');
                                        var inputSecond =
                                            inputFormatSecond.parse(secondColl);
                                        var outputFormatSecond =
                                            DateFormat('hh:mm');
                                        var outputSecond = outputFormatSecond
                                            .format(inputSecond);
                                        total_balance = (int.parse(
                                                details.data[index].total) +
                                            int.parse(
                                                details.data[index].feeBeever));
                                        return Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                      child: details
                                                                  .data[index]
                                                                  .driver
                                                                  .image ==
                                                              null
                                                          ? Image.asset(
                                                              'images/input/beever.png',
                                                              width: 70)
                                                          : Image.network(
                                                              'https://staging2.junkbee.id/storage/profile-images/${details.data[index].driver.image}',
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit
                                                                  .cover)),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                details
                                                                    .data[index]
                                                                    .driver
                                                                    .fullName,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        18)),
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          'images/input/group_2191.png',
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20),
                                                                      const Text(
                                                                          '4.5 | 20 Points',
                                                                          style: TextStyle(
                                                                              color: Color(0xFF707070),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 16))
                                                                    ]))
                                                          ]))
                                                ]),
                                                Container(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                      Text(outputDate,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF707070),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16)),
                                                      const Text('Verified',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF707070),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 17))
                                                    ]))
                                              ]),
                                          Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xFFDEDEDE))))),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '$outputSecond | $intlDateColl',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16)),
                                                    Text(
                                                        'Collection Nr.: \n${widget.orderCode}',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16))
                                                  ])),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xFFDEDEDE))))),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: const Text(
                                                        'Details of Collection',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20))),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 19,
                                                            bottom: 10),
                                                    child: const Text(
                                                        'Category',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 18))),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color: const Color(
                                                                0xFF707070)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(widget.type,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xFF707070),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 18)))),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    height: 100,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: widget
                                                            .images.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: Container(
                                                                      width: 78,
                                                                      height:
                                                                          78,
                                                                      child: Image.network(
                                                                          '${widget.urlImages}${widget.images[index]['directory']}',
                                                                          fit: BoxFit
                                                                              .cover))));
                                                        })),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Row(children: [
                                                      Container(
                                                          width: 80,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: const Text(
                                                              'Summary',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      18))),
                                                      Row(children: [
                                                        Container(
                                                            width: 90,
                                                            child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Container(
                                                                    width: 60,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                1.0),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10)),
                                                                    child: TextFormField(
                                                                        controller:
                                                                            weight,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        decoration: const InputDecoration(
                                                                            labelStyle: TextStyle(
                                                                                color: Color(0xFF707070),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 18),
                                                                            border: InputBorder.none),
                                                                        style: const TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.w400, fontSize: 16))))),
                                                        Container(
                                                            width: 30,
                                                            child: const Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    'kg',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF707070),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            20))))
                                                      ]),
                                                      Container(
                                                          width: 115,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: GestureDetector(
                                                              onTap: () => update_collection(),
                                                              child: Container(
                                                                  decoration: BoxDecoration(color: const Color(0xFFF8C503), borderRadius: BorderRadius.circular(16.7), boxShadow: const [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        blurRadius:
                                                                            2,
                                                                        spreadRadius:
                                                                            0.0,
                                                                        offset: Offset(
                                                                            0,
                                                                            1))
                                                                  ]),
                                                                  child: const Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15), child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18))))))
                                                    ]))
                                              ]),
                                          const SizedBox(height: 25)
                                          // Container(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 15),
                                          //     decoration: const BoxDecoration(
                                          //         border: Border(
                                          //             bottom: BorderSide(
                                          //                 color: Color(
                                          //                     0xFFDEDEDE))))),
                                          // Container(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 25, bottom: 40),
                                          //     width: 386.1,
                                          //     child: Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           const Text(
                                          //               'Release to Beever',
                                          //               style: TextStyle(
                                          //                   color: Color(
                                          //                       0xFF707070),
                                          //                   fontWeight:
                                          //                       FontWeight.w400,
                                          //                   fontSize: 18)),
                                          //           Text(
                                          //               format.format(
                                          //                   total_balance),
                                          //               style: const TextStyle(
                                          //                   color: Color(
                                          //                       0xFF707070),
                                          //                   fontWeight:
                                          //                       FontWeight.w700,
                                          //                   fontSize: 18))
                                          //         ]))
                                        ]);
                                      });
                                }
                                return Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    height: 70,
                                    child: const LoadingIndicator(
                                        indicatorType:
                                            Indicator.ballSpinFadeLoader,
                                        colors: [Color(0xFFF8C503)],
                                        backgroundColor: Colors.transparent));
                              }))),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 37.3, bottom: 34.7, left: 30, right: 30),
                      child: GestureDetector(
                          onTap: () {
                            showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      insetPadding: const EdgeInsets.all(0),
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          width: 350,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                        'images/input/checked_success.png',
                                                        width: 100)),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 15),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Text(
                                                        'Transaction Completed',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.center)),
                                                // Container(
                                                //     padding:
                                                //         const EdgeInsets.only(
                                                //             bottom: 45),
                                                //     width:
                                                //         MediaQuery.of(context)
                                                //             .size
                                                //             .width,
                                                //     child: const Text(
                                                //         'Your balance now',
                                                //         style: TextStyle(
                                                //             color: Color(
                                                //                 0xFF707070),
                                                //             fontWeight:
                                                //                 FontWeight.w400,
                                                //             fontSize: 18),
                                                //         textAlign:
                                                //             TextAlign.center)),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
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
                                                          var duration =
                                                              const Duration(
                                                                  seconds: 1);
                                                          Timer(duration, () {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: const Text('OK',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    20)))),
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
                              child: const Text('Received',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20)))))
                ]))));
  }
}
