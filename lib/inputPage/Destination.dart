import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Travelnation/utils/db_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/card_items.dart';

void main() async {
  runApp(const Destination());
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: const DestinationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationData();
}

class _DestinationAdd extends State<DestinationPage> {
  final DBHelper dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _destinations = [];

  @override
  void initState() {
    super.initState();
    _refreshDestination();
  }

  void _refreshDestination() async {
    final data = await dbHelper.queryAlldestinations();
    setState(() {
      _destinations = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              width: 350,
              height: 850,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                            width: 4.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Destination Form",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 15), // Jarak antara teks dan TextField
                            const Text(
                              'Destination Name *',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            ),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: _destinationController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 15), // Jarak antara teks dan TextField
                            const Text(
                              'Location *',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: _locationController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 15), // Jarak antara teks dan TextField
                            const Text(
                              'Description *',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 80, 140, 1)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Center(
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      // if (_formKey.currentState!.validate()) {
                                      //   if (id == null) {
                                      //     _addDestination();
                                      //   }
                                      //    else {
                                      //     _updateDestination(int id);
                                      //   }
                                      //   Navigator.of(context).pop();
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: const Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ), // Jarak antara teks dan TextField
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addDestination() async {
    await dbHelper.insertDestination({
      'destination': _destinationController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
    });
    _refreshDestination();
  }

  // Future<void> _updateDestination(int id) async {
  //   await dbHelper._updateDestination({
  //     'id': id,
  //     'destination': _destinationController.text,
  //     'location': _locationController.text,
  //     'description': _descriptionController.text,
  //   });
  //   _refreshDestination();
  // }

  //   void _deleteDestination(int id) async {
  //   await dbHelper._deleteDestination(id);
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('User deleted')));
  //   _refreshDestination();
  // }
}

class _DestinationData extends State<DestinationPage> {
  bool isPressed = false;

  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _destinations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
          elevation: 0,
          leading: BackAnimate(),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 10, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Destination Data",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SvgPicture.asset(
                  "assets/images/TravelNation_SVGLogo.svg",
                  semanticsLabel: 'TravelNation Logo',
                  width: 80,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SearchBar(),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  //Destination Data Cards
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: ListView(
                    
                    children: [
                      //testing
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                      CardItems(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  GestureDetector BackAnimate() {
    return GestureDetector(
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
              duration: const Duration(
                  milliseconds:
                      300), // Menggunakan milliseconds untuk animasi yang lebih terlihat
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isPressed
                  ? SvgPicture.asset(
                      "assets/images/BackClicked.svg", // SVG yang ditampilkan saat tombol ditekan
                      key: ValueKey("clicked"),
                      width: 40,
                      height: 40,
                    )
                  : SvgPicture.asset(
                      "assets/images/Back.svg", // SVG awal
                      key: ValueKey('default'),
                      height: 40,
                      width: 40,
                    ),
            ),
          ),
        );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //SearchBar
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Search Destination',
            labelStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  "assets/images/icon-search.svg",
                  width: 24,
                  height: 24,
                ),
              ),
            )),
      ),
    );
  }
}
