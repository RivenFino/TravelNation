import 'dart:io';
import 'package:Travelnation/inputPage/Destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Travelnation/utils/db_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainTravelNationApp(initialPageIndex: 0));
}

class MainTravelNationApp extends StatelessWidget {
  final int initialPageIndex;
  MainTravelNationApp({Key? key, required this.initialPageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: MainPage(initialPageIndex: initialPageIndex),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/dashboard': (context) => MainPage(initialPageIndex: 0),
        '/profile': (context) => MainPage(initialPageIndex: 1),
        '/bookmark': (context) => MainPage(initialPageIndex: 2),
        '/destination': (context) => Destination(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  int initialPageIndex;
  MainPage({Key? key, required this.initialPageIndex}) : super(key: key);

  @override
  
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    UserSettings(),
    BookmarkPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (_currentIndex) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/usercircle.svg"),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bookmark),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPage();
}

class _BookmarkPage extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/destination');
          },
          child: Text('Go to Destination Page'),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  final DBHelper dbHelper = DBHelper();
  File? _selectedImage;
  List<Map<String, dynamic>> _destinations = [];

  @override
    void initState() {
    super.initState();
    _refreshDestinations();
  }

  void _refreshDestinations() async {
    final data = await dbHelper.queryAllDestinations();
    setState(() {
      _destinations = data;
    });
  }
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
          )),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(
                        "assets/images/TravelNationLogoBlue.svg",
                        semanticsLabel: 'TravelNation Logo',
                        color: Colors.white,
                        width: 80,
                      ),
                    ),
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
                //SearchBar
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Search Destination',
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset(
                            "assets/images/icon-search.svg",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._destinations.take(8).map((destination) {
                return Padding(
                  //Destination Data Cards
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                  child: Container(
                    //Card Element
                    padding: EdgeInsets.all(4),
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        )),
                    child: Row(
                      children: [
                        ////Left
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              )),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: destination['imagePath'] != null
                                ? Image.file(
                                    File(destination['imagePath']),
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.location_city_rounded, size: 50),
                          ),
                        ),
                        //// Mid
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  destination['destination'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 4),
                                        child: Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 15,
                                          color:
                                              Color.fromRGBO(107, 107, 107, 1),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          destination['location'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        ////Right
                      ],
                    ),
                  ),
                );
              }),
            ],
          )
      ],
    ));
  }
}
