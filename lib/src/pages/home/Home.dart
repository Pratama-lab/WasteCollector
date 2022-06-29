// ignore_for_file: file_names, sized_box_for_whitespace, avoid_print, unnecessary_string_interpolations, unnecessary_const, avoid_unnecessary_containers, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waste_collection/src/services/Notification.dart';
import 'package:waste_collection/src/api/api_server.dart';
import 'package:waste_collection/src/api/api_call_get_data.dart';
import 'package:waste_collection/src/services/string_extension.dart';
import 'CollectionReceived.dart';
import 'History.dart';
import 'package:waste_collection/src/pages/input/Input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    if (mounted) {
      ApiGetHomeData().getData();
      ApiGetUpcoming().getData();
      ApiGetCollectionReceived().getData();
      ApiGetHistoryTransaction().getData();
    }

    Provider.of<NotificationService>(context, listen: false).initialize();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      AndroidInitializationSettings androidInitializationSettings =
          const AndroidInitializationSettings("ic_launcher");

      final InitializationSettings initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      var android = const AndroidNotificationDetails('id', 'name',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high);

      var platform = NotificationDetails(android: android);

      await _flutterLocalNotificationsPlugin.show(message.notification.hashCode,
          message.notification?.title, message.notification?.body, platform,
          payload: "Welcome to demo app");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      AndroidInitializationSettings androidInitializationSettings =
          const AndroidInitializationSettings("ic_launcher");

      final InitializationSettings initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      var android = const AndroidNotificationDetails('id', 'channel',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high);

      var platform = NotificationDetails(android: android);

      await _flutterLocalNotificationsPlugin.show(event.notification.hashCode,
          event.notification?.title, event.notification?.body, platform,
          payload: "Welcome to demo app");
    });
  }

  Stream<ApiGetUpcoming> upcomingStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      ApiGetUpcoming someUpcoming =
          ApiGetUpcoming().getData() as ApiGetUpcoming;
      yield someUpcoming;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: MediaQuery.of(context).size.width,
          height: 280,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/heading.png'), fit: BoxFit.fill)),
          child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: FutureBuilder(
                  future: ApiGetHomeData().getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var collector = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done) {
                      String dateTime = collector.data.createdAt;
                      String date =
                          dateTime.substring(0, dateTime.indexOf('T'));
                      String time =
                          dateTime.substring(dateTime.indexOf('T') + 1);
                      String second = time.substring(0, time.indexOf('Z'));
                      var jiffy = Jiffy(DateTime.parse('$date $second'))
                          .format("MMM do, yyyy");
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: GestureDetector(
                                    onTap: () => print('Profile'),
                                    child: Row(children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: collector.data.image == null
                                              ? Image.asset(
                                                  'images/home/ellipse_302.png',
                                                  width: 60)
                                              : Image.network(
                                                  '${API.API_URL}storage/profile-images/${collector.data.image}',
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover)),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${collector?.data.fullName}',
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 17)),
                                                const Text('Collector',
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 17))
                                              ]))
                                    ]))),
                            Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // GestureDetector(
                                          //     onTap: () async {
                                          //       final result =
                                          //           await Navigator.push(
                                          //               context,
                                          //               MaterialPageRoute(
                                          //                   builder: (context) =>
                                          //                       WalletScreen()));
                                          //       if (result == 'back') {
                                          //         await ApiGetHomeData()
                                          //             .getData();
                                          //         if (mounted) {
                                          //           setState(() {});
                                          //         }
                                          //       }
                                          //     },
                                          //     child: Row(children: [
                                          //       Image.asset(
                                          //           'images/home/icon_wallet.png',
                                          //           width: 40),
                                          //       Container(
                                          //           padding:
                                          //               const EdgeInsets.only(
                                          //                   left: 10),
                                          //           child: Column(children: [
                                          //             Text(
                                          //                 '${format.format(int.parse(collector?.data.balance))}',
                                          //                 style: const TextStyle(
                                          //                     color: const Color(
                                          //                         0xFFFFFFFF),
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w700,
                                          //                     fontSize: 17))
                                          //           ]))
                                          //     ])),
                                          Container(),
                                          Text('$jiffy',
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17))
                                        ])))
                          ]);
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 800,
                          color: Colors.transparent,
                          child: Center(
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  child: const LoadingIndicator(
                                      indicatorType:
                                          Indicator.ballSpinFadeLoader,
                                      colors: [Colors.white],
                                      backgroundColor: Colors.transparent))));
                    }
                  }))),
      Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.7),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 1))
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Row(children: [
                                const Text('Upcoming Collection',
                                    style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text('- Today',
                                        style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)))
                              ])),
                              Container(
                                  child: Image.asset(
                                      'images/home/group_2188.png',
                                      width: 25))
                            ])),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Container(
                            decoration: const BoxDecoration(
                                border: const Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFDEDEDE)))))),
                    Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: FutureBuilder(
                            future: ApiGetUpcoming().getData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              var upcoming = snapshot.data;
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  upcoming.data.length != 0) {
                                return ListView.separated(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    shrinkWrap: true,
                                    itemCount: upcoming.data.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, index) {
                                      final status =
                                          '${upcoming.data[index].status}'
                                              .capitalize();
                                      String dateTime =
                                          upcoming.data[index].createdAt;
                                      String time = dateTime
                                          .substring(dateTime.indexOf('T') + 1);
                                      String second =
                                          time.substring(0, time.indexOf('Z'));
                                      //format second
                                      var inputFormatSecond =
                                          DateFormat('HH:mm');
                                      var inputSecond =
                                          inputFormatSecond.parse('$second');
                                      var outputFormatSecond =
                                          DateFormat('hh:mm a');
                                      var outputSecond = outputFormatSecond
                                          .format(inputSecond);
                                      return Table(columnWidths: const {
                                        0: FractionColumnWidth(.4),
                                        1: FractionColumnWidth(.2),
                                        2: FractionColumnWidth(.2)
                                      }, children: [
                                        TableRow(children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '$status by ${upcoming.data[index].driver.fullName} #${upcoming.data[index].orderCode}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text('$outputSecond',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)))
                                              ]),
                                          Column(children: [
                                            Text(
                                                '${upcoming.data[index].totalWeight} Kg',
                                                style: const TextStyle(
                                                    color: Color(0xFF707070),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16)),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Text('Est Weight',
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w400)))
                                          ]),
                                          Column(children: [
                                            Text(
                                                '${format.format(int.parse(upcoming.data[index].total))}',
                                                style: const TextStyle(
                                                    color:
                                                        const Color(0xFF707070),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16)),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Text('Est Price',
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF707070),
                                                        fontWeight:
                                                            FontWeight.w400)))
                                          ])
                                        ])
                                      ]);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider());
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  upcoming.data.length == 0) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text('Belum ada data hari ini',
                                        style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                        textAlign: TextAlign.center));
                              }
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.transparent,
                                  child: Center(
                                      child: Container(
                                          width: 70,
                                          height: 70,
                                          child: const LoadingIndicator(
                                              indicatorType:
                                                  Indicator.ballSpinFadeLoader,
                                              colors: [Colors.amber],
                                              backgroundColor:
                                                  Colors.transparent))));
                            }))
                  ]))),
      Container(
          transform: Matrix4.translationValues(0.0, -25.0, 0.0),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => InputScreen())),
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.7),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 1))
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(children: [
                          Image.asset('images/home/group_2183.png',
                              width: 35, color: const Color(0xFFF8C503)),
                          Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text('Scan Collection Number',
                                  style: TextStyle(
                                      color: const Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)))
                        ])),
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF8C503),
                                borderRadius: BorderRadius.circular(45)),
                            child: Center(
                                child: Image.asset('images/home/group_1633.png',
                                    width: 25, height: 25)))
                      ])))),
      Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const Text('Quick Links',
              style: TextStyle(
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.w700,
                  fontSize: 20))),
      Container(
          padding:
              const EdgeInsets.only(top: 22, bottom: 120, left: 20, right: 20),
          child: Row(children: [
            GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CollectionReceivedScreen())),
                child: Container(
                    width: 160,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              spreadRadius: 0.0,
                              offset: Offset(0, 1))
                        ]),
                    child: Stack(children: [
                      Column(children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future:
                                          ApiGetCollectionReceived().getData(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        var received = snapshot.data;
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Text('${received.data.length}',
                                              style: const TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 19));
                                        }
                                        return Container(
                                            width: 70,
                                            height: 10,
                                            child: const LoadingIndicator(
                                                indicatorType:
                                                    Indicator.ballPulse,
                                                colors: [Color(0xFFF8C503)],
                                                backgroundColor:
                                                    Colors.transparent));
                                      }),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      size: 15, color: Color(0xFFD2D2D2))
                                ])),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 9, left: 10, right: 10),
                            child: const Text(
                              'Collection Received',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ))
                      ]),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              child: Container(
                                  width: 160.7,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF59A7FF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16))))))
                    ]))),
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryScreen())),
                    child: Container(
                        width: 160,
                        height: 120,
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
                        child: Stack(children: [
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FutureBuilder(
                                          future: ApiGetHistoryTransaction()
                                              .getData(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            var history = snapshot.data;
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text(
                                                  '${history.data.length}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 19));
                                            }
                                            return Container(
                                                width: 70,
                                                height: 10,
                                                child: const LoadingIndicator(
                                                    indicatorType:
                                                        Indicator.ballPulse,
                                                    colors: [Color(0xFFF8C503)],
                                                    backgroundColor:
                                                        Colors.transparent));
                                          }),
                                      const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                          color: Color(0xFFD2D2D2))
                                    ])),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 9, left: 10, right: 10),
                                child: const Text('History Transaction',
                                    style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17)))
                          ]),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  child: Container(
                                      width: 160.7,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFA8E8B0),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight:
                                                  Radius.circular(16))))))
                        ]))))
          ]))
    ])));
  }
}
