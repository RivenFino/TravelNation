import 'package:Travelnation/splashscreen/1page.dart';
import 'package:Travelnation/splashscreen/2.page.dart';
import 'package:Travelnation/splashscreen/3page.dart';
import 'package:flutter/material.dart';
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
      title: 'Welcome',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
      ),
      initialRoute: "/first",
      debugShowCheckedModeBanner: false,
    );
  }
}


class Page1 extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
   return LandingPage1();
  }
}
class Page2 extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
   return LandingPage2();
  }
}

class Page3 extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
   return LandingPage3();
  }
}



class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.jpg",
            ),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.702),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 70, bottom: 50),
                child: Container(
                  child: SvgPicture.asset(
                    "assets/images/TravelNation_SVGLogo.svg",
                    semanticsLabel: 'TravelNation Logo',
                    width: 200,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.only(top: 48, bottom: 48),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Take the time",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Text(
                        "to explore various places around you.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/page1");
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'Start Exploring',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
