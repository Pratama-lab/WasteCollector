// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, non_constant_identifier_names, unused_local_variable, sized_box_for_whitespace, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'WithdrawConfirm.dart';
import 'AddBankAccount.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<WithdrawScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');
  List BankAccount = [
    {
      'id': 1,
      'bank_name': 'BCA',
      'no_rek': '00973538296',
      'name': 'Joko Widodo Sudirjo'
    },
    {'id': 2, 'bank_name': 'BCA', 'no_rek': '00973538296', 'name': 'Michael'}
  ];
  List VirtualAccount = [
    {
      'id': 1,
      'bank_name': 'OVO',
      'name': 'Joko Widodo Sudirjo',
      'no_rek': '085848670282',
      'image': 'images/home/logo_ovo_pay.png'
    },
    {
      'id': 2,
      'bank_name': 'DANA',
      'name': 'Michael',
      'no_rek': '085848670282',
      'image': 'images/home/rectangle_1869.png'
    }
  ];
  String name = '';
  String no_rek = '';
  String payment_method = '';
  int? id_payment;

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
                  onTap: () => Navigator.pop(context, 'back'),
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
                              child: const Text('Your Total Balance',
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
                                    fontSize: 28)));
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
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Available for Withdraw',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          Text(' Rp 100.000',
                              style: TextStyle(
                                  color: Color(0xFF2AAE1B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16))
                        ])),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text('Choose your bank account',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: GestureDetector(
                        onTap: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBankAccountScreen(),
                              ));
                          if (result == 'back') {
                            await ApiGetHomeData().getData();
                            setState(() {});
                          }
                        },
                        child: Row(children: [
                          Image.asset('images/home/subtraction_2.png',
                              width: 25),
                          Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text('Add Bank Account',
                                  style: TextStyle(
                                      color: Color(0xFF2AAE1B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)))
                        ]))),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: BankAccount.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Color(0xFFDEDEDE)))),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = BankAccount[index]['name'];
                                    no_rek = BankAccount[index]['no_rek'];
                                    payment_method =
                                        BankAccount[index]['bank_name'];
                                    id_payment = BankAccount[index]['id'];
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                                    BankAccount[index]['name'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16))),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Text(
                                                    BankAccount[index]
                                                        ['bank_name'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16))),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Text(
                                                    BankAccount[index]
                                                        ['no_rek'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)))
                                          ]),
                                      (id_payment == BankAccount[index]['id'] &&
                                              payment_method ==
                                                  BankAccount[index]
                                                      ['bank_name']
                                          ? Image.asset(
                                              'images/input/group_2201.png',
                                              width: 20)
                                          : Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))))
                                    ]))),
                      );
                    }),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text('Or choose virtual account',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: VirtualAccount.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                            padding: const EdgeInsets.only(top: 25, bottom: 10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Color(0xFFDEDEDE)))),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = VirtualAccount[index]['name'];
                                    no_rek = VirtualAccount[index]['no_rek'];
                                    payment_method =
                                        VirtualAccount[index]['bank_name'];
                                    id_payment = VirtualAccount[index]['id'];
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Image.asset(
                                              VirtualAccount[index]['image'],
                                              width: 80)),
                                      (id_payment ==
                                                  VirtualAccount[index]['id'] &&
                                              payment_method ==
                                                  VirtualAccount[index]
                                                      ['bank_name']
                                          ? Image.asset(
                                              'images/input/group_2201.png',
                                              width: 20)
                                          : Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))))
                                    ]))),
                      );
                    }),
                Container(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: GestureDetector(
                        onTap: () async {
                          var result = await Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => WithdrawConfirmScreen(
                                name: name,
                                bank_name: payment_method,
                                no_rek: no_rek),
                          ));
                          if (result == 'back') {
                            await ApiGetHomeData().getData();
                            setState(() {});
                          }
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
                            child: const Center(
                                child: Text('Continue',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20))))))
              ]))),
    );
  }
}
