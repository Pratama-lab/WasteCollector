// ignore_for_file: use_key_in_widget_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_renaming_method_parameters, file_names, sized_box_for_whitespace, avoid_print, use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:waste_collection/src/api/api_server.dart';
import 'TopUpConfirm.dart';

class TopUp extends StatefulWidget {
  @override
  TopUpState createState() => TopUpState();
}

class TopUpState extends State<TopUp> {
  TextEditingController amount = TextEditingController();
  bool loading = false;
  String image = '';
  String payment_method = '';
  List bank = [
    {'id': 1, 'bank_name': 'BCA', 'image': 'images/home/bank_central_asia.png'},
    {'id': 2, 'bank_name': 'BRI', 'image': 'images/home/group_1739.png'},
    {'id': 3, 'bank_name': 'MANDIRI', 'image': 'images/home/bank_mandiri.png'},
    {'id': 4, 'bank_name': 'BNI', 'image': 'images/home/layer_3.png'}
  ];

  _topUp() async {
    if (payment_method == 'BCA' ||
        payment_method == 'BRI' ||
        payment_method == 'BNI') {
      setState(() => loading = true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');

      final top_up = await http.post(Uri.parse(API.API_URL + API.top_up),
          headers: {'Authorization': 'Bearer $token'},
          body: {'amount': amount.text.trim(), 'bank': payment_method});
      Map<String, dynamic> bodyJson = jsonDecode(top_up.body);

      var va_numbers = jsonEncode(bodyJson['data']['va_numbers']);
      String x1 = va_numbers;
      var x2 = jsonDecode(x1);
      List? list = x2 != null ? List.from(x2) : null;
      if (bodyJson['message'] == 'data has been updated') {
        setState(() => loading = false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopUpConfirm(
                image: image,
                amount: amount.text,
                bank_name: list![0]['bank'],
                no_rek: list[0]['va_number'],
                id_transaksi: bodyJson['data']['transaction_id'])));
      }
    } else if (payment_method == 'MANDIRI') {
      setState(() {
        loading = false;
      });
      setState(() => loading = true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');

      final top_up = await http.post(Uri.parse(API.API_URL + API.top_up),
          headers: {'Authorization': 'Bearer $token'},
          body: {'amount': amount.text.trim(), 'bank': payment_method});
      Map<String, dynamic> bodyJson = jsonDecode(top_up.body);

      if (bodyJson['message'] == 'data has been updated') {
        setState(() => loading = false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopUpConfirm(
                image: image,
                amount: amount.text,
                bank_name: 'mandiri',
                no_rek: bodyJson['data']['permata_va_number'],
                id_transaksi: bodyJson['data']['transaction_id'])));
      }
    }
  }

  _onWillPop() {
    Navigator.pop(context, 'back');
  }

  @override
  Widget build(BuildContext) {
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: const Color(0xFFF8C503),
                title: const Text('TopUp',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)),
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context, 'back'),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white))),
            body: Stack(children: [
              SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 20),
                                child: const Text('Top Up Trough',
                                    style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                            Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                    controller: amount,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'Input Nominal',
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Color(0xFF707070)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.7),
                                            borderSide: const BorderSide(
                                                color: Colors.black45,
                                                width: 2.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.7),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFF8C503),
                                                width: 2.0))))),
                            Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    title: const Text('Transfer Bank',
                                        style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18)),
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: bank.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          payment_method =
                                                              bank[index]
                                                                  ['bank_name'];
                                                          image = bank[index]
                                                              ['image'];
                                                        });
                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  bottom: 20),
                                                          child: Row(children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                child: payment_method ==
                                                                        bank[index]
                                                                            [
                                                                            'bank_name']
                                                                    ? Image.asset(
                                                                        'images/home/group_2201.png',
                                                                        width:
                                                                            20)
                                                                    : Container(
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(width: 1),
                                                                            borderRadius: BorderRadius.circular(20)))),
                                                            Container(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xFFFFFDF5),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: const Color(
                                                                            0xFF40F8C503))),
                                                                width: 80,
                                                                height: 35,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Image.asset(
                                                                    bank[index][
                                                                        'image'],
                                                                    height:
                                                                        20)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                          'Bank ${bank[index]['bank_name']} (Dicek Otomatis)',
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w800,
                                                                              fontSize: 15,
                                                                              color: Color(0xFF707070))),
                                                                      Text(
                                                                          'Hanya menerima dari ${bank[index]['bank_name']}',
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              color: Color(0xFF707070)))
                                                                    ]))
                                                          ])))
                                                ]);
                                          })
                                    ])),
                            const Padding(padding: EdgeInsets.only(top: 100)),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 65,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        primary: const Color(0xFFF8C503)),
                                    onPressed: () => _topUp(),
                                    child: const Text('Continue',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20))))
                          ]))),
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
                              backgroundColor: Colors.transparent)))
                  : Container()
            ])));
  }
}
