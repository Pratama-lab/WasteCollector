// ignore_for_file: file_names, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_renaming_method_parameters, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_print, deprecated_member_use, must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:waste_collection/src/api/api_server.dart';

class TopUpConfirm extends StatefulWidget {
  String image;
  String amount;
  String bank_name;
  String no_rek;
  String id_transaksi;
  TopUpConfirm(
      {Key? key,
      required this.image,
      required this.amount,
      required this.bank_name,
      required this.no_rek,
      required this.id_transaksi})
      : super(key: key);

  @override
  TopUpConfirmState createState() => TopUpConfirmState();
}

class TopUpConfirmState extends State<TopUpConfirm> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');
  bool loading = false;

  cancel_topup() async {
    setState(() => loading = true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    final response = await http.post(Uri.parse(API.API_URL + API.cancel_topup),
        headers: {'Authorization': 'Bearer $token'},
        body: {'transaction_id': widget.id_transaksi});
    Map<String, dynamic> bodyJson = jsonDecode(response.body);
    if (bodyJson['message'] == 'data has been updated') {
      setState(() => loading = false);
      Fluttertoast.showToast(
          msg: 'Anda sudah membatalkan proses Top Up Anda',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: const Color(0xFFF8C503));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: key,
        appBar: AppBar(
            backgroundColor: const Color(0xFFF8C503),
            title: const Text('Top Up',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22)),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white))),
        body: Stack(alignment: Alignment.topCenter, children: [
          Column(children: [
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 80,
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(0, 1))
                ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Amount',
                          style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400,
                              fontSize: 16)),
                      Text('${format.format(int.parse(widget.amount))}',
                          style: const TextStyle(
                              color: Color(0xFFF30000),
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ])),
            const Padding(padding: EdgeInsets.only(top: 7)),
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(0, 1))
                ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 22)),
                      Row(children: [
                        Image.asset(widget.image, width: 75),
                        Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                'Bank ${widget.bank_name.toUpperCase()} (Dicek Otomatis)',
                                style: const TextStyle(
                                    color: Color(0xFF707070),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)))
                      ]),
                      Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFDEDEDE)),
                                  borderRadius: BorderRadius.circular(10)))),
                      Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: const Text('No. Rekening',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.no_rek,
                              style: const TextStyle(
                                  color: Color(0xFFF30000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.no_rek));
                                  key.currentState!.showSnackBar(const SnackBar(
                                      content: Text("Copied to Clipboard")));
                                },
                                child: const Text('Salin',
                                    style: TextStyle(
                                        color: Color(0xFF88D1F0),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)))
                          ]),
                      Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: const Color(0xFFDEDEDE)),
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Text(
                              'Transfer pembayaran Top Up Anda melalui Virtual Account dari Bank ${widget.bank_name.toUpperCase()}',
                              style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)))
                    ])),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 250),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            primary: const Color(0xFFF8C503)),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20))))),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            primary: const Color(0xFFF30000)),
                        onPressed: () {
                          showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 1,
                                    backgroundColor: Colors.white,
                                    insetPadding: const EdgeInsets.all(0),
                                    child: Container(
                                        width: 350,
                                        height: 250,
                                        alignment: Alignment.center,
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(),
                                                            GestureDetector(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: Image.asset(
                                                                    'images/profile/group_2210.png',
                                                                    width: 20))
                                                          ])),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 45),
                                                    child: const Text(
                                                        'Anda yakin ingin membatalkan proses Top Up Anda?',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18)),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () => Navigator
                                                                    .of(context)
                                                                .pop(),
                                                            child: Container(
                                                                width: 160,
                                                                height: 60,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: const Text(
                                                                    'Tidak',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF707070),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            20)))),
                                                        Container(
                                                            width: 160,
                                                            height: 60,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10)),
                                                                        primary:
                                                                            const Color(
                                                                                0xFFF8C503)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      cancel_topup();
                                                                    },
                                                                    child: const Text(
                                                                        'Ya',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 20))))
                                                      ]),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 15))
                                                ]))));
                              },
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(seconds: 1));
                        },
                        child: const Text('Cancel',
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
                      height: 100,
                      child: const LoadingIndicator(
                        indicatorType: Indicator.lineSpinFadeLoader,
                        colors: [Color(0xFFF8C503)],
                        backgroundColor: Colors.transparent,
                      )))
              : Container()
        ]));
  }
}
