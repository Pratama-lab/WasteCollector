// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print, unnecessary_const, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, must_be_immutable, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';

class WithdrawConfirmScreen extends StatefulWidget {
  String name;
  String bank_name;
  String no_rek;
  WithdrawConfirmScreen(
      {Key? key,
      required this.name,
      required this.bank_name,
      required this.no_rek})
      : super(key: key);

  @override
  _WithdrawConfirmState createState() => _WithdrawConfirmState();
}

class _WithdrawConfirmState extends State<WithdrawConfirmScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onWillPop() {
    Navigator.pop(context, 'back');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          appBar: AppBar(
              title: const Text(
                'Withdraw',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFFF8C503),
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white))),
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/home/wallet_svgrepo_com.png',
                              width: 25),
                          Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text('Your Available Balance',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)))
                        ])),
                FutureBuilder(
                    future: ApiGetHomeData().getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var saldo = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                            padding: const EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Text(
                                format.format(int.parse(saldo?.data.balance)),
                                style: const TextStyle(
                                    color: Color(0xFF707070),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30)));
                      }
                      return Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Container(
                              width: 100,
                              height: 20,
                              child: const LoadingIndicator(
                                  strokeWidth: 1,
                                  indicatorType: Indicator.ballPulse,
                                  colors: [Color(0xFFF8C503)],
                                  backgroundColor: Colors.transparent)));
                    }),
                Container(
                    padding:
                        const EdgeInsets.only(top: 26, left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Enter amount',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          GestureDetector(
                              onTap: () => print('enter all amount'),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset('images/home/subtraction_2.png',
                                        width: 25),
                                    Container(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: const Text('Enter all amount',
                                            style: TextStyle(
                                                color: Color(0xFF2AAE1B),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)))
                                  ]))
                        ])),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: '100.000',
                          hintStyle: const TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1.0, color: Color(0xFF707070)),
                              borderRadius: BorderRadius.circular(5)))),
                ),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text('Send to',
                        style: TextStyle(
                            color: const Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name,
                                    style: const TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(widget.bank_name,
                                        style: const TextStyle(
                                            color: Color(0xFF707070),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16))),
                                Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(widget.no_rek,
                                        style: const TextStyle(
                                            color: Color(0xFF707070),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)))
                              ]),
                          GestureDetector(
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
                                              child: Container(
                                                  width: 350,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(),
                                                                GestureDetector(
                                                                    onTap: () =>
                                                                        Navigator.of(context)
                                                                            .pop(),
                                                                    child: Image.asset(
                                                                        'images/profile/group_2210.png',
                                                                        width:
                                                                            20))
                                                              ],
                                                            )),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 18,
                                                                  bottom: 45),
                                                          child: const Text(
                                                              'Anda yakin ingin membatalkan proses Top Up Anda?',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child:
                                                                    Container(
                                                                        width:
                                                                            175,
                                                                        height:
                                                                            60,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child:
                                                                            const Text(
                                                                          'Tidak',
                                                                          style: TextStyle(
                                                                              color: Color(0xFF707070),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 20),
                                                                        ))),
                                                            Container(
                                                              width: 175,
                                                              height: 60,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  10)),
                                                                          primary: const Color(
                                                                              0xFFF8C503)),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        var duration =
                                                                            const Duration(milliseconds: 500);
                                                                        Timer(
                                                                            duration,
                                                                            () =>
                                                                                Navigator.pop(context, 'back'));
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Ya',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 20),
                                                                      )),
                                                            )
                                                          ],
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 15))
                                                      ]))));
                                    },
                                    animationType: DialogTransitionType
                                        .slideFromBottomFade,
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(seconds: 1));
                              },
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF707070),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Image.asset(
                                          'images/home/union_84.png',
                                          width: 20))))
                        ])),
                Container(
                    padding:
                        const EdgeInsets.only(top: 150, left: 20, right: 20),
                    child: GestureDetector(
                        onTap: () => print('withdraw'),
                        child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF8C503),
                                borderRadius: BorderRadius.circular(16.7),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      spreadRadius: 0.0,
                                      offset: Offset(0, 1))
                                ]),
                            child: const Center(
                                child: Text('Withdraw',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20))))))
              ]))),
    );
  }
}
