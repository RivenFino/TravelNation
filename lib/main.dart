import 'package:Travelnation/splashscreen/1page.dart';
import 'package:Travelnation/splashscreen/2.page.dart';
import 'package:Travelnation/splashscreen/3page.dart';
import 'package:flutter/material.dart';
import 'package:Travelnation/first_page.dart';
import 'inputPage/Destination.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
      ),
      routes: {
        "/first" :(context) => Destination(),
        "/page1" :(context) => Page1(),
        "/page2" :(context) => Page2(),
        "/page3" :(context) => Page3(),
        "/destination" :(context) => Destination(),
      },
      home: FirstPage(),
    );
  }
}