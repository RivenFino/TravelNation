import 'package:Travelnation/main/dashboard.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Travelnation/utils/db_helper.dart';

class DetailDestinationPage extends StatefulWidget {
  final int destinationId;
  const DetailDestinationPage({Key? key, required this.destinationId})
      : super(key: key);

  @override
  State<DetailDestinationPage> createState() => _DetailDestination();
}

class _DetailDestination extends State<DetailDestinationPage> {
  bool isPressed = false;
  bool isBookmarked = false;
  
  final DBHelper dbHelper = DBHelper();
  Map<String, dynamic>? _destination;

  @override
  void initState() {
    super.initState();
    _loadDestination();
  }

  void _loadDestination() async {
    final data = await dbHelper.getDestinationById(widget.destinationId);
    bool bookmarked = await dbHelper.isBookmarked(widget.destinationId);
    setState(() {
      _destination = data;
      isBookmarked = bookmarked; // Menggunakan isBookmarked dari parameter local
    });
  }
  

  Future<void> _toggleBookmark(int destinationId) async {
    bool isBookmarked = await dbHelper.isBookmarked(destinationId);
    if (isBookmarked) {
      await dbHelper.removeBookmark(destinationId);
    } else {
      await dbHelper.addBookmark(destinationId);
    }
    _loadDestination();
  }

  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(23, 233, 242, 250),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainTravelNationApp(initialPageIndex: 1)),
            ); // Navigasi kembali ke halaman sebelumnya saat tombol ditekan
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
              duration: Duration(
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
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 20, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: Text(
                  _destination != null ? _destination!['destination'] : '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
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
      body: _destination != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      image: _destination!['imagePath'] != null
                          ? DecorationImage(
                              image: File(_destination!['imagePath'])
                                      .existsSync()
                                  ? FileImage(File(_destination!['imagePath']))
                                  : AssetImage(_destination!['imagePath'])
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage(
                                  "assets/images/TravelNationLogo.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Container(
                    height: 60,
                    color: Color.fromRGBO(207, 229, 249, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            _destination!['location'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 50)
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.35,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          _destination!['description'],
                          textAlign: TextAlign.justify,
                          style:
                              TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ElevatedButton(
                              onPressed: () {
                                _toggleBookmark(_destination!['id']);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(67, 169, 243, 1),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                width: 170,
                                child: Text(
                                  isBookmarked
                                      ? "Remove Bookmark"
                                      : "Add To Bookmark",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
