import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainTravelNationApp extends StatelessWidget {
  MainTravelNationApp({super.key});

  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(20, 80, 140, 1),
                Color.fromRGBO(30, 100, 165, 0.75),
                Color.fromRGBO(45, 130, 190, 0.45),
                Color.fromRGBO(65, 150, 235, 0),
              ],
            )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(
                          "assets/images/TravelNation_SVGLogo.svg",
                          semanticsLabel: 'TravelNation Logo',
                          width: 80,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text("Location, City")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Container(
                      width: 240,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Where Would You Like to visit?",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    width: double.infinity,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search Your Destination",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          Icon(FontAwesomeIcons.search),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: NavigationBar(
            indicatorColor: Colors.white30,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            destinations: <Widget>[
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.home), label: 'Home'),
              NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/usercircle.svg',
                    width: 25,
                    height: 25,
                  ),
                  label: 'Username'),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.bookmark), label: 'Bookmark'),
            ],
          ),
        ),
      ),
    );
  }
}
