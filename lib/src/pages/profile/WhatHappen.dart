// ignore_for_file: file_names, non_constant_identifier_names, override_on_non_overriding_member, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, library_private_types_in_public_api

import 'package:flutter/material.dart';

class WhatHappen extends StatefulWidget {
  const WhatHappen({Key? key}) : super(key: key);
  @override
  _WhatHappenState createState() => _WhatHappenState();
}

class _WhatHappenState extends State<WhatHappen> {
  List what_happen = [
    {'id': 1, 'desc': 'Something wrong with this order'},
    {'id': 2, 'desc': 'About fee transaction'},
    {'id': 3, 'desc': 'Others.'}
  ];
  String selected_desc = '';

  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFFF8C503),
            title: const Text('What Happening?',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22)),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white))),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: what_happen.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected_desc =
                                          what_happen[index]['desc'];
                                    });
                                  },
                                  child: selected_desc ==
                                          what_happen[index]['desc']
                                      ? const Icon(Icons.check_box_rounded,
                                          color: Color(0xFFF8C503))
                                      : const Icon(
                                          Icons.check_box_outline_blank_rounded,
                                          color: Color(0xFF707070))),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('${what_happen[index]['desc']}',
                                      style: const TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17)))
                            ]),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFDEDEDE)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17),
                                      hintText: 'Describe your reason',
                                      border: InputBorder.none)))),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 100, bottom: 50, left: 10, right: 10),
                          child: GestureDetector(
                              onTap: () => print('submit'),
                              child: Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF8C503),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1))
                                      ]),
                                  alignment: Alignment.center,
                                  child: const Text('Submit',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20)))))
                    ]))));
  }
}
