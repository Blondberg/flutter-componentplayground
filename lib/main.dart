import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_componentplayground/screens/home/home_screen.dart';
import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kDefaultBackground, // navigation bar color
    statusBarColor: kDefaultBackground, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Roboto", scaffoldBackgroundColor: kDefaultBackground),
      home: const HomeScreen(),
    );
  }
}
