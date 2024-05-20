import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '2.page.dart';

class LandingPage1 extends StatefulWidget {
  LandingPage1({super.key});

  @override
  State<LandingPage1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LandingPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 6, 51, 118),
              Colors.blue.shade300
            ], // Warna gradasi
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                  child: SvgPicture.asset(
                "assets/images/Icon1.svg",
                semanticsLabel: 'icon1',
              )),
            ),
            Container(
              width: 420,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Route",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Welcome to TravelNation! Discover new adventures with the best routes we offer. Start now and explore your dream destinations!",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage2()),
                );
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade300),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
