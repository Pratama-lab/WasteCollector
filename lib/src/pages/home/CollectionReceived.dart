// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/services/string_extension.dart';

class CollectionReceivedScreen extends StatefulWidget {
  @override
  _CollectionReceivedScreenState createState() =>
      _CollectionReceivedScreenState();
}

class _CollectionReceivedScreenState extends State<CollectionReceivedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  TextEditingController search = TextEditingController();

  List<String> collection_type = ['All Type', 'Paper', 'Mix Paper'];
  int index_type = 0;
  var start_date;
  var start_date_database;
  var finish_date;
  var finish_date_database;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      ApiSearchCollectionReceived().getData(search.text);
    }

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  filterSearch() async {
    setState(() {
      start_date_database = null;
      finish_date_database = null;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(
        Uri.parse(
            '${API.API_URL}${API.collectionReceived}?search=${search.text}'),
        headers: {'Authorization': 'Bearer $token'});
    Map<String, dynamic> bodyJSON = jsonDecode(response.body);
    if (bodyJSON['message'] == 'data found') {
      if (mounted) {
        ApiSearchCollectionReceived().getData(search.text);
        setState(() {});
      }
    }
  }

  filterApply() async {
    switch (controller.status) {
      case AnimationStatus.completed:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');

        var response = await http.get(
            Uri.parse(
                '${API.API_URL}${API.collectionReceived}?start_date=$start_date_database&finish_date=$finish_date_database'),
            headers: {'Authorization': 'Bearer $token'});
        Map<String, dynamic> bodyJSON = jsonDecode(response.body);
        if (bodyJSON['message'] == 'data found') {
          if (mounted) {
            ApiFilterDateCollectionReceived()
                .getData(start_date_database, finish_date_database);
            setState(() {});
          }
        }
        controller.reverse();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection Received',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Color(0xFFF8C503),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white)),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: GestureDetector(
        //           onTap: () => print('Save'),
        //           child:
        //               Image.asset('images/home/group_2212.png', width: 30)))
        // ]
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.only(top: 33.5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Color(0xFF707070)))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 300,
                                  child: TextFormField(
                                      controller: search,
                                      onEditingComplete: filterSearch,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Search user by name, number or email',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF707070),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17),
                                          border: InputBorder.none))),
                              Image.asset('images/home/group_2213.png',
                                  width: 25)
                            ])),
                    Container(
                        padding: const EdgeInsets.only(top: 24.6),
                        child: GestureDetector(
                            onTap: () {
                              switch (controller.status) {
                                case AnimationStatus.dismissed:
                                  controller.forward();
                                  break;
                                default:
                              }
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.7),
                                    gradient: LinearGradient(colors: const [
                                      Color(0xFFF8C503),
                                      Color(0xFFFFE067)
                                    ])),
                                alignment: Alignment.center,
                                child: Text('Filter by: All Time',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18))))),
                    // Container(
                    //     padding: const EdgeInsets.only(top: 24.7),
                    //     width: MediaQuery.of(context).size.width,
                    //     child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           GestureDetector(
                    //               child: Transform.rotate(
                    //                   angle: 3.1,
                    //                   child: Image.asset(
                    //                       'images/home/group_1916.png',
                    //                       width: 25))),
                    //           GestureDetector(
                    //               child: Transform.rotate(
                    //                   angle: 3.1,
                    //                   child: Image.asset(
                    //                       'images/home/group_2184.png',
                    //                       width: 25))),
                    //           Container(
                    //               padding:
                    //                   const EdgeInsets.only(left: 5, right: 5),
                    //               child: Text(
                    //                 'Page 1 of 1',
                    //                 style: TextStyle(
                    //                     color: Color(0xFF707070),
                    //                     fontWeight: FontWeight.w400,
                    //                     fontSize: 14),
                    //               )),
                    //           GestureDetector(
                    //               child: Image.asset(
                    //                   'images/home/group_2184.png',
                    //                   width: 25)),
                    //           GestureDetector(
                    //               child: Image.asset(
                    //                   'images/home/group_1916.png',
                    //                   width: 25))
                    //         ])),
                    Container(
                        padding: const EdgeInsets.only(top: 18.7, bottom: 38),
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
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
                            child: Column(children: [
                              Table(
                                  defaultColumnWidth: FixedColumnWidth(68),
                                  children: [
                                    TableRow(children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Order No.',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Order by',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Date',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Beever',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Status',
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ])
                                    ])
                                  ]),
                              Padding(padding: const EdgeInsets.only(top: 10)),
                              start_date_database != null &&
                                      finish_date_database != null
                                  ? FutureBuilder(
                                      future: ApiFilterDateCollectionReceived()
                                          .getData(start_date_database,
                                              finish_date_database),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        var received = snapshot.data;
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return ListView.separated(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: received.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                final order_by =
                                                    '${received.data[index].user.fullName}'
                                                        .titleCase();
                                                final beever =
                                                    '${received.data[index].driver.fullName}'
                                                        .titleCase();
                                                final status =
                                                    '${received.data[index].status}'
                                                        .titleCase();
                                                var inputFormat =
                                                    DateFormat('yyyy-MM-dd');
                                                var inputDate = inputFormat.parse(
                                                    '${received.data[index].date}');
                                                var outputFormat =
                                                    DateFormat('dd/MM/yy');
                                                var outputDate = outputFormat
                                                    .format(inputDate);
                                                return Table(
                                                    defaultColumnWidth:
                                                        FixedColumnWidth(68),
                                                    children: [
                                                      TableRow(children: [
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '${received.data[index].orderCode}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$order_by',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '$outputDate',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$beever',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$status',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ])
                                                      ])
                                                    ]);
                                              },
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  const Divider(
                                                      color:
                                                          Color(0xFFDEDEDE)));
                                        }
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                      })
                                  : FutureBuilder(
                                      future: ApiSearchCollectionReceived()
                                          .getData(search.text),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        var received = snapshot.data;
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return ListView.separated(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: received.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                final order_by =
                                                    '${received.data[index].user.fullName}'
                                                        .titleCase();
                                                final beever =
                                                    '${received.data[index].driver.fullName}'
                                                        .titleCase();
                                                final status =
                                                    '${received.data[index].status}'
                                                        .titleCase();
                                                var inputFormat =
                                                    DateFormat('yyyy-MM-dd');
                                                var inputDate = inputFormat.parse(
                                                    '${received.data[index].date}');
                                                var outputFormat =
                                                    DateFormat('dd/MM/yy');
                                                var outputDate = outputFormat
                                                    .format(inputDate);
                                                return Table(
                                                    defaultColumnWidth:
                                                        FixedColumnWidth(68),
                                                    children: [
                                                      TableRow(children: [
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '${received.data[index].orderCode}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$order_by',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '$outputDate',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$beever',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ]),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('$status',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400))
                                                            ])
                                                      ])
                                                    ]);
                                              },
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  const Divider(
                                                      color:
                                                          Color(0xFFDEDEDE)));
                                        }
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                      })
                            ])))
                  ]))
            ])),
        Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                    position: offset,
                    child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(0, 1))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text('By Date',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20))),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(children: [
                                    GestureDetector(
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2022, 01, 01),
                                              maxTime: DateTime.now(),
                                              theme: DatePickerTheme(
                                                  headerColor:
                                                      Color(0xFFF8C503),
                                                  backgroundColor:
                                                      Color(0xFFF8C503),
                                                  itemStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                  doneStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                              onConfirm: (date) {
                                            String dateTime = date.toString();
                                            String date1 = dateTime.substring(
                                                0, dateTime.indexOf(' '));
                                            var inputFormatStartDate =
                                                DateFormat('yyyy-MM-dd');
                                            var inputStartDate =
                                                inputFormatStartDate
                                                    .parse('$date1');
                                            var outputFormatStartDate =
                                                DateFormat('dd/MM/yy');
                                            var outputStartDate =
                                                outputFormatStartDate
                                                    .format(inputStartDate);
                                            setState(() {
                                              start_date = outputStartDate;
                                              start_date_database = date1;
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.id);
                                        },
                                        child: Container(
                                            width: 150,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF0F0F0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.center,
                                            child: start_date == '' ||
                                                    start_date == null
                                                ? const Text('DD / MM / YY',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16))
                                                : Text(start_date!,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16)))),
                                    Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: const Icon(Icons.remove,
                                            color: Color(0xFF707070))),
                                    GestureDetector(
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2022, 01, 01),
                                              maxTime: DateTime.now(),
                                              theme: DatePickerTheme(
                                                  headerColor:
                                                      Color(0xFFF8C503),
                                                  backgroundColor:
                                                      Color(0xFFF8C503),
                                                  itemStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                  doneStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                              onConfirm: (date) {
                                            String dateTime = date.toString();
                                            String date1 = dateTime.substring(
                                                0, dateTime.indexOf(' '));
                                            var inputFormatFinishDate =
                                                DateFormat('yyyy-MM-dd');
                                            var inputFinishDate =
                                                inputFormatFinishDate
                                                    .parse('$date1');
                                            var outputFormatFinishDate =
                                                DateFormat('dd/MM/yy');
                                            var outputFinishDate =
                                                outputFormatFinishDate
                                                    .format(inputFinishDate);
                                            setState(() {
                                              finish_date = outputFinishDate;
                                              finish_date_database = date1;
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.id);
                                        },
                                        child: Container(
                                            width: 150,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF0F0F0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.center,
                                            child: finish_date == '' ||
                                                    finish_date == null
                                                ? const Text('DD / MM / YY',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16))
                                                : Text(finish_date!,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16))))
                                  ])),
                              Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xFFDEDEDE))))),
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text('Collection Type',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20))),
                              GridView.count(
                                  padding: const EdgeInsets.only(top: 0),
                                  shrinkWrap: true,
                                  childAspectRatio: (1 / .5),
                                  crossAxisCount: 4,
                                  children: List.generate(
                                      collection_type.length, (index) {
                                    return index_type == index
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index_type = index;
                                              });
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF8C503),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              blurRadius: 2,
                                                              spreadRadius: 0,
                                                              offset:
                                                                  Offset(0, 1))
                                                        ]),
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Text(
                                                            '${collection_type[index]}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    16))))))
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index_type = index;
                                              });
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.black26,
                                                          blurRadius: 2,
                                                          spreadRadius: 0,
                                                          offset: Offset(0, 1))
                                                    ]),
                                                    child: Container(child: Text('${collection_type[index]}', style: TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.w500, fontSize: 16))))));
                                  })),
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 50, bottom: 30, left: 20, right: 20),
                                  child: GestureDetector(
                                      onTap: () => filterApply(),
                                      child: Container(
                                          height: 65,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF8C503),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 1))
                                              ]),
                                          alignment: Alignment.center,
                                          child: Text('Apply',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20)))))
                            ])))))
      ]),
    );
  }
}
