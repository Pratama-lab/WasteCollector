import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CollectionReceivedScreen extends StatefulWidget {
  @override
  _CollectionReceivedScreenState createState() => _CollectionReceivedScreenState();
}

class _CollectionReceivedScreenState extends State<CollectionReceivedScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  List<String> collection_type = ['All Type', 'Plastic', 'Metal', 'Paper', 'Glass', 'Sachet'];
  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 904),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('Collection Received', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          backgroundColor: Color(0xFFF8C503),
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TouchableOpacity(
                onTap: () => print('Save'),
                child: Image.asset('images/home/group_2212.png', width: ScreenUtil().setWidth(35), height: ScreenUtil().setHeight(35),)
              )
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(805),
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 33.5),
                            width: ScreenUtil().setWidth(418.6),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFF707070)))
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenUtil().setWidth(383.6),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Search user by name, number or email',
                                      hintStyle: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 17.sp),
                                      border: InputBorder.none
                                    ),
                                  )
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(35),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('images/home/group_2213.png', width: ScreenUtil().setWidth(30), height: ScreenUtil().setHeight(30),),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(top: 24.6),
                            child: TouchableOpacity(
                              onTap: () {
                                switch (controller.status) {
                                  case AnimationStatus.dismissed:
                                    controller.forward();
                                    break;
                                  default:
                                }
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(400.7),
                                height: ScreenUtil().setHeight(60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.7),
                                  gradient: LinearGradient(colors: [Color(0xFFF8C503), Color(0xFFFFE067)])
                                ),
                                child: Center(
                                  child: Text('Filter by: All Time, All Status, All Type', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp,),)
                                ),
                              ),
                            )
                          ),

                          Container(
                            padding: const EdgeInsets.only(top: 24.7),
                            width: ScreenUtil().setWidth(400.7),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: ScreenUtil().setWidth(195),
                                child: Row(
                                  children: [
                                    TouchableOpacity(
                                      child: Transform.rotate(
                                        angle: 3.1,
                                        child: Image.asset('images/home/group_1916.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                                      )

                                    ),
                                    TouchableOpacity(
                                      child: Transform.rotate(
                                        angle: 3.1,
                                        child: Image.asset('images/home/group_2184.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                                      )
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Text('Page 1 of 1', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),)
                                    ),
                                    TouchableOpacity(
                                      child: Image.asset('images/home/group_2184.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                                    ),
                                    TouchableOpacity(
                                      child: Image.asset('images/home/group_1916.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),)
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(top: 18.7, bottom: 38),
                            child: Container(
                              width: ScreenUtil().setWidth(440.7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                                    child: Container(
                                      width: ScreenUtil().setWidth(405.8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil().setWidth(81.16),
                                            child: Text('Order No.', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(81.16),
                                            child: Text('Order by', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(81.16),
                                            child: Text('Date', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(81.16),
                                            child: Text('Beever', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(81.16),
                                            child: Text('Status', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 14.sp),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: ScreenUtil().setWidth(405.8),
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (BuildContext context, index) {
                                        return Container(
                                          padding: const EdgeInsets.only(top: 18, bottom: 19),
                                          width: ScreenUtil().setWidth(405.8),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: ScreenUtil().setWidth(81.16),
                                                child: Text('PLT7258', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(81.16),
                                                child: Text('Sunaryo', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(81.16),
                                                child: Text('18/09/21', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(81.16),
                                                child: Text('Searching..', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(81.16),
                                                child: Text('On Going', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 16.sp),),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),

            Container(
              width: ScreenUtil().setWidth(480),
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: offset,
                child: Container(
                  width: ScreenUtil().setWidth(480),
                  height: ScreenUtil().setHeight(300),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 2, offset: Offset(0, 1))]
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: ScreenUtil().setWidth(430),
                        child: Text('By Date', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: ScreenUtil().setWidth(430),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFDEDEDE)))),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: ScreenUtil().setWidth(430),
                        child: Text('Collection Type', style: TextStyle(color: Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                      ),
                      // ListView.builder(itemBuilder: itemBuilder),

                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: TouchableOpacity(
                          onTap: () {
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                controller.reverse();
                                break;
                              default:
                            }
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(430),
                            height: ScreenUtil().setHeight(70),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8C503),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1))]
                            ),
                            alignment: Alignment.center,
                            child: Text('Apply', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp))
                          )
                        )
                      ),
                    ],
                  )
                )
              ),
            )
          ],
        )
      )
    );
  }
}