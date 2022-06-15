// ignore_for_file: file_names, unused_import, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailCollectionScreen extends StatefulWidget {
  //beever info
  String image = '';
  String fullName = '';
  String created = '';
  //order info
  String orderCode = '';
  String weight = '';
  String feeBeever = '';
  String urlImages = '';
  List images = [];
  DetailCollectionScreen(
      {Key? key,
      required this.image,
      required this.fullName,
      required this.created,
      required this.orderCode,
      required this.weight,
      required this.feeBeever,
      required this.urlImages,
      required this.images})
      : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollectionScreen> {
  TextEditingController weight = TextEditingController();
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    super.initState();
    if (widget.weight != null) {
      weight.text = widget.weight;
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
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    widget.image == 'null'
                                        ? Image.asset('images/input/beever.png',
                                            width: 70, height: 70)
                                        : Image.network(
                                            'https://staging2.junkbee.id/storage/profile-images/${widget.image}',
                                            width: 70,
                                            height: 70),
                                    Container(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.fullName,
                                                  style: const TextStyle(
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Row(children: [
                                                    Image.asset(
                                                        'images/input/group_2191.png',
                                                        width: 20,
                                                        height: 20),
                                                    const Text(
                                                        '4.5 | 20 Points',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16))
                                                  ]))
                                            ]))
                                  ]),
                                  Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                        Text('03/04/2021',
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16)),
                                        Text('Verified',
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17))
                                      ]))
                                ]),
                            Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFDEDEDE))))),
                            Container(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('09.30 | 11 Jul 2021',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16)),
                                      Text(
                                          'Collection Nr.: \n${widget.orderCode}',
                                          style: const TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16))
                                    ])),
                            Container(
                                padding: const EdgeInsets.only(top: 15),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFDEDEDE))))),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: const Text('Details of Collection',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20))),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 19, bottom: 10),
                                      child: const Text('Category',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18))),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Paper',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18)))),
                                  Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      height: 100,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: widget.images.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                        width: 78,
                                                        height: 78,
                                                        child: Image.network(
                                                            '${widget.urlImages}${widget.images[index]['directory']}',
                                                            fit: BoxFit
                                                                .cover))));
                                          })),
                                  Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(children: [
                                        Container(
                                            width: 80,
                                            alignment: Alignment.centerLeft,
                                            child: const Text('Summary',
                                                style: TextStyle(
                                                    color: Color(0xFF707070),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18))),
                                        Row(children: [
                                          Container(
                                              width: 90,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                      width: 60,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      child: TextFormField(
                                                          controller: weight,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration: const InputDecoration(
                                                              labelStyle: TextStyle(
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 18),
                                                              border: InputBorder.none),
                                                          style: const TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.w400, fontSize: 16))))),
                                          Container(
                                              width: 30,
                                              child: const Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text('kg',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 20))))
                                        ]),
                                        Container(
                                            width: 115,
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                                onTap: () => print('Pressed'),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF8C503),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.7),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 2,
                                                              spreadRadius: 0.0,
                                                              offset:
                                                                  Offset(0, 1))
                                                        ]),
                                                    child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 15,
                                                                bottom: 15),
                                                        child: Text('Confirm',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    18))))))
                                      ]))
                                ]),
                            Container(
                                padding: const EdgeInsets.only(top: 15),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFDEDEDE))))),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 40),
                                width: 386.1,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Release to Beever',
                                          style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18)),
                                      Text(
                                          format.format(
                                              int.parse(widget.feeBeever)),
                                          style: const TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18))
                                    ]))
                          ]))),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 37.3, bottom: 34.7, left: 30, right: 30),
                      child: GestureDetector(
                          onTap: () => print('Pressed'),
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
