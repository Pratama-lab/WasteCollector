// ignore_for_file: file_names, unused_import, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailCollectionScreen extends StatefulWidget {
  const DetailCollectionScreen({Key? key}) : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollectionScreen> {
  List<Asset> images = <Asset>[];

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          padding: const EdgeInsets.only(bottom: 10, left: 10),
          child: Stack(
            children: [
              Container(
                width: ScreenUtil().setWidth(89.4),
                height: ScreenUtil().setHeight(90.4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  )
                )
              )
            ],
          ),
        );
      })
    );
  }

  Future<void> takePhoto() async {
    List<Asset> resultList = <Asset>[];
    if (await Permission.camera.request().isGranted && await Permission.storage.request().isGranted) {
      var status = await Permission.camera.status;
      var state = await Permission.storage.status;
      if (status.isGranted && state.isGranted) {
        print('access granted');
        try {
          resultList = await MultiImagePicker.pickImages(
            maxImages: 300,
            enableCamera: true,
            selectedAssets: images,
            cupertinoOptions: const CupertinoOptions(
              takePhotoIcon: "chat",
              doneButtonTitle: "Fatto",
            ),
            materialOptions: const MaterialOptions(
              actionBarColor: "#abcdef",
              actionBarTitle: "Example App",
              allViewTitle: "All Photos",
              useDetailsView: false,
              selectCircleStrokeColor: "#000000",
            ),
          );
        } catch (e) {
          print(e.toString());
        }

        if (!mounted) return;
        setState(() {
          images = resultList;
        });
      } else {
        print('access denied');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 904),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('Input Collection', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 24.sp),),
          centerTitle: true,
          backgroundColor: const Color(0xFFF8C503),
          leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 25)
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, left: 5),
                          width: ScreenUtil().setWidth(417.3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.7),
                            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset('images/input/beever.png', width: ScreenUtil().setWidth(85), height: ScreenUtil().setHeight(85),),
                                  Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(180),
                                          child: Text('Sunaryo', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 21.sp),)
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 5),
                                          width: ScreenUtil().setWidth(180),
                                          child: Row(
                                            children: <Widget>[
                                              Image.asset('images/input/group_2191.png', width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25),),
                                              Text('4.5 | 20 Points', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(125),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('03/04/2021', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),)
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 5),
                                          width: ScreenUtil().setWidth(125),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('Verified', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 18.sp),)
                                          ),
                                        )
                                      ],
                                    )
                                  )
                                ],
                              ),

                              Container(
                                width: ScreenUtil().setWidth(386.1),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 15, left: 11),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(180),
                                      child: Text('09.30 | 11 Jul 2021', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(206),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Collection Nr.: 3749', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 18.sp),),
                                      )
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 15),
                                width: ScreenUtil().setWidth(386.1),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                ),
                              ),

                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    width: ScreenUtil().setWidth(386.1),
                                    child: Text('details of collection', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 21.sp),),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 19, bottom: 10),
                                    width: ScreenUtil().setWidth(386.1),
                                    child: Text('Category', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 21.sp),),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width: ScreenUtil().setWidth(386.1),
                                    height: ScreenUtil().setHeight(65),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Paper', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 21.sp),),
                                    )
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(top: 35),
                                    width: ScreenUtil().setWidth(386.1),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TouchableOpacity(
                                          onTap: () => takePhoto(),
                                          child: Container(
                                            width: ScreenUtil().setWidth(89.4),
                                            height: ScreenUtil().setHeight(90.4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF8C503),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Image.asset('images/input/group_2196.png', width: ScreenUtil().setWidth(47.8), height: ScreenUtil().setHeight(48.1),),
                                            ),
                                          )
                                        ),

                                        Expanded(child: buildGridView())
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.only(top: 20, left: 11),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(100),
                                          child: Text('Summary', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(150),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil().setWidth(110),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Container(
                                                    width: ScreenUtil().setWidth(80),
                                                    height: ScreenUtil().setHeight(60),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(width: 1.0),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: TextFormField(
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                        labelStyle: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),
                                                        border: InputBorder.none
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(40),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text('kg', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(135),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TouchableOpacity(
                                              onTap: () => print('Pressed'),
                                              child: Container(
                                                width: ScreenUtil().setWidth(110),
                                                height: ScreenUtil().setHeight(60),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF8C503),
                                                  borderRadius: BorderRadius.circular(16.7),
                                                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Confirm', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                                ),
                                              )
                                            ),
                                          )
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 15),
                                width: ScreenUtil().setWidth(386.1),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFDEDEDE)))
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(top: 25, left: 11),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(190),
                                      child: Text('Release to Beever', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(195),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Rp -', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                      )
                                    )
                                  ],
                                )
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10, left: 11, bottom: 40),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(190),
                                      child: Text('Release to Customer', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillic', fontSize: 20.sp),),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(195),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Rp -', style: TextStyle(color: const Color(0xFF707070), fontFamily: 'DiodrumCyrillicBold', fontSize: 20.sp),),
                                      )
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 37.3, bottom: 34.7),
                        child: TouchableOpacity(
                          onTap: () => print('Pressed'),
                          child: Container(
                            width: ScreenUtil().setWidth(392),
                            height: ScreenUtil().setHeight(70),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8C503),
                              borderRadius: BorderRadius.circular(16.7),
                              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0.0, offset: Offset(0, 1))]
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Received', style: TextStyle(color: Colors.white, fontFamily: 'DiodrumCyrillicBold', fontSize: 22.sp),),
                            )
                          )
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}