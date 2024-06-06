import 'dart:io';
import 'package:Travelnation/inputPage/Destination.dart';
import 'package:Travelnation/main/detail_page.dart';
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(64, 151, 232, 1),
            brightness: Brightness.light),
        fontFamily: 'Montserrat',
      ),
      routes: {
        '/dashboard': (context) => MainPage(initialPageIndex: 0),
        '/profile': (context) => MainPage(initialPageIndex: 1),
        '/bookmark': (context) => BookmarkPage(),
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
        Navigator.push(context,MaterialPageRoute(builder: (context) =>BookmarkPage()));
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
        backgroundColor: Colors.white,
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
  BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPage();
}

class _BookmarkPage extends State<BookmarkPage> {
  bool isPressed = false;
  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>> _bookmarks = [];
  
  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  Future<void> _fetchBookmarks() async {
    List<Map<String, dynamic>> bookmarkList = await dbHelper.getBookmarks();
    List<Map<String, dynamic>> destinations = [];
  
    // Loop through each bookmark and fetch destination details
    for (var bookmark in bookmarkList) {
      Map<String, dynamic>? destination = await dbHelper.getDestinationById(bookmark['destinationId']);
      if (destination != null) {
        destinations.add(destination);
      }
    }

    setState(() {
      _bookmarks = destinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 80, 140, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainTravelNationApp(initialPageIndex: 1)),
            );
          },
          onTapDown: (_) {
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              isPressed = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 0, 6),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isPressed
                  ? SvgPicture.asset(
                      "assets/images/BackClicked.svg",
                      key: ValueKey("clicked"),
                      width: 40,
                      height: 40,
                    )
                  : SvgPicture.asset(
                      "assets/images/Back.svg",
                      key: ValueKey('default'),
                      height: 40,
                      width: 40,
                    ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 18, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bookmark",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SvgPicture.asset(
                "assets/images/TravelNation_SVGLogo.svg",
                semanticsLabel: 'TravelNation Logo',
                width: 80,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._bookmarks.map((destination) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Container(
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
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 4),
                                        child: Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 15,
                                          color: Color.fromRGBO(107, 107, 107, 1),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailDestinationPage(
                                        destinationId: destination['id'])),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(64, 151, 232, 1),
                              ),
                              child: Text(
                                "Route",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
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
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(20, 80, 140, 1),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 34, 6),
                child: SvgPicture.asset(
                  "assets/images/TravelNation_SVGLogo.svg",
                  semanticsLabel: 'TravelNation Logo',
                  width: 80,
                  color: Colors.white,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: SvgPicture.asset(
                      'assets/images/usercircle.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'U******@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(248, 248, 248, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                                  width: 1.5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/destination');
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Destination Data',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(64, 151, 232, 1)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(248, 248, 248, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                                  width: 1.5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/bookmark');
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Bookmark',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(64, 151, 232, 1)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>> _destinations = [];

  TextEditingController _searchInputController = TextEditingController();
  var list = [];
  var filteredList = [];
  final _searchController = TextEditingController();
  bool doItJustOnce = false;

  @override
  Future<void> _searchDestination(String searchTerm) async {
    final data = await dbHelper.searchDestination(searchTerm);
    if (searchTerm == null || searchTerm.isEmpty) {
      _refreshDestinations();
    }
    setState(() {
      _destinations = data;
    });
  }

  void _filterList(value) {
    setState(() {
      filteredList = list
          .where(
              (text) => text.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                      padding: const EdgeInsets.fromLTRB(18, 26, 18, 12),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: TextField(
                        onSubmitted: (searchTerm) =>
                            _searchDestination(searchTerm),
                        controller: _searchController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Search the Destination',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  _searchDestination(_searchController.text),
                              icon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
              //Car Slide Horizontal
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ..._destinations.take(4).map((destination) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: destination['imagePath'] != null
                                    ? DecorationImage(
                                        image: File(destination['imagePath'])
                                                .existsSync()
                                            ? FileImage(
                                                File(destination['imagePath']))
                                            : AssetImage(
                                                    destination['imagePath'])
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(
                                            "assets/images/TravelNationLogo.png"),
                                        fit: BoxFit.contain,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 6),
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(240, 240, 240, 0.7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 6),
                                            child: Container(
                                              width: 90,
                                              child: Text(
                                                destination['destination'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12)
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailDestinationPage(
                                                          destinationId:
                                                              destination[
                                                                  'id'])),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromRGBO(
                                                  64, 151, 232, 1),
                                            ),
                                            child: Text(
                                              "Route",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nearest Places",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
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
                                        : const Icon(
                                            Icons.location_city_rounded,
                                            size: 50),
                                  ),
                                ),
                                //// Mid
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 4),
                                                child: Icon(
                                                  FontAwesomeIcons.locationDot,
                                                  size: 15,
                                                  color: Color.fromRGBO(
                                                      107, 107, 107, 1),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  destination['location'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailDestinationPage(
                                                    destinationId:
                                                        destination['id'])),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromRGBO(
                                            64, 151, 232, 1),
                                      ),
                                      child: Text(
                                        "Route",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
