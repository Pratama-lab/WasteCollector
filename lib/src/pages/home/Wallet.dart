// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/services/string_extension.dart';
import 'Withdraw.dart';
import 'TopUp.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    if (mounted) {
      ApiGetHistoryTransaction().getData();
    }
  }

  _onWillPop() {
    Navigator.pop(context, 'back');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration:
                      const BoxDecoration(color: Color(0xFFF8C503), boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        spreadRadius: 0.0,
                        offset: Offset(0, 1))
                  ]),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('images/home/mask_group_31.png'))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 50, left: 20, right: 20),
                                child: Row(children: [
                                  GestureDetector(
                                      onTap: () =>
                                          Navigator.pop(context, 'back'),
                                      child: const Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Colors.white)),
                                  Container(
                                      width: 300,
                                      alignment: Alignment.topCenter,
                                      child: const Text('Wallet',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22)))
                                ])),
                            Container(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/home/icon_wallet.png',
                                          width: 30),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: const Text('Your Cash',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16)))
                                    ])),
                            FutureBuilder(
                                future: ApiGetHomeData().getData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  var saldo = snapshot.data;
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                        padding: const EdgeInsets.only(top: 12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                            '${format.format(int.parse(saldo?.data.balance))}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28)));
                                  }
                                  return Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Container(
                                          width: 100,
                                          height: 20,
                                          child: const LoadingIndicator(
                                              strokeWidth: 1,
                                              indicatorType:
                                                  Indicator.ballPulse,
                                              colors: [Colors.white],
                                              backgroundColor:
                                                  Colors.transparent)));
                                })
                          ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 0.0,
                                offset: Offset(0, 1))
                          ]),
                      child: Row(children: [
                        Container(
                            width: 175,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 0.5, color: Color(0xFFDEDEDE)))),
                            child: GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WithdrawScreen()));
                                  if (result == 'back') {
                                    await ApiGetHomeData().getData();
                                    setState(() {});
                                  }
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/home/group_885.png',
                                          width: 40),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: const Text('Withdraw',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17)))
                                    ]))),
                        Container(
                            width: 175,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 0.5, color: Color(0xFFDEDEDE)))),
                            child: GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TopUp()));
                                  if (result == 'back') {
                                    await ApiGetHomeData().getData();
                                    setState(() {});
                                  }
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/home/group_886.png',
                                          width: 40),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: const Text('Top Up',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17)))
                                    ])))
                      ]))),
              Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: const Text('History Transaction',
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w500,
                          fontSize: 18))),
              Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 0.0,
                                offset: Offset(0, 1))
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: FutureBuilder(
                                    future:
                                        ApiGetHistoryTransaction().getData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      var history = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return ListView.separated(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: history.data.length,
                                            separatorBuilder:
                                                (BuildContext context, index) {
                                              return const Divider();
                                            },
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              final status =
                                                  '${history.data[index].status}'
                                                      .capitalize();
                                              final type =
                                                  '${history.data[index].type}'
                                                      .capitalize();
                                              return Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 18),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              history
                                                                          .data[
                                                                              index]
                                                                          .type ==
                                                                      'topup'
                                                                  ? Text(
                                                                      '+ ${format.format(int.parse(history.data[index].amount))}',
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xFF707070),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              15))
                                                                  : Text(
                                                                      '- ${format.format(int.parse(history.data[index].amount))}',
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xFF707070),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              15)),
                                                              Text(
                                                                  '${history.data[index].user.fullName}',
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15)),
                                                              const Text(
                                                                  'Melvin BCA 009866248',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  'Today 06:42   $status',
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15)),
                                                              Text(
                                                                  '$type \nNo. WTD008373535',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15))
                                                            ])
                                                      ]));
                                            });
                                      }
                                      return Container(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  child: const LoadingIndicator(
                                                      indicatorType: Indicator
                                                          .ballSpinFadeLoader,
                                                      colors: [Colors.amber],
                                                      backgroundColor: Colors
                                                          .transparent))));
                                    }))
                          ])))
            ]))));
  }
}
