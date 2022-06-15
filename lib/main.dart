// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './src/Splash.dart';
import 'package:waste_collection/src/services/Notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.amber,
                fontFamily: 'DiodrumCyrillic',
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Color(0xFF707070))),
            home: SplashScreen()),
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationService())
        ]);
  }
}
