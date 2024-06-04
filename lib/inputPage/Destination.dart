import 'package:Travelnation/main/dashboard.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:Travelnation/utils/db_helper.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Destination());
}

class Destination extends StatelessWidget {
  Destination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: DestinationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  State<DestinationPage> createState() => _DestinationData();
}

class _DestinationData extends State<DestinationPage> {
  bool isPressed = false;

  final DBHelper dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showForm(int? id) {
    if (id != null) {
      final existingDestination =
          _destinations.firstWhere((element) => element['id'] == id);
      _destinationController.text = existingDestination['destination'];
      _locationController.text = existingDestination['location'];
      _descriptionController.text = existingDestination['description'];
      _image = existingDestination['imagePath'] != null
          ? File(existingDestination['imagePath'])
          : null;
    } else {
      _destinationController.clear();
      _locationController.clear();
      _descriptionController.clear();
      _image = null;
    }

    showModalBottomSheet(
        context: context,
        elevation: 2,
        builder: (BuildContext context) {
          return Container(
            height: 600,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _image == null
                          ? TextButton.icon(
                              icon: const Icon(Icons.image),
                              label: const Text('Pick Image'),
                              onPressed: _pickImage,
                            )
                          : Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    child: Image.file(_image!, height: 80, width: 80, fit: BoxFit.cover,),
                                  ),
                                  TextButton.icon(
                                    icon: const Icon(Icons.image),
                                    label: const Text('Change Image'),
                                    onPressed: _pickImage,
                                  ),
                                ],
                              ),
                          ),
                      const SizedBox(height: 10),
                      Text(
                        "Destination Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 151, 232, 0.5),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Destination Name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "location",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 151, 232, 0.5),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Location';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 151, 232, 0.5),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: Text(id == null ? 'Create' : 'Update'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (id == null) {
                          _addDestinations();
                        } else {
                          _updateDestinations(id);
                        }

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _addDestinations() async {
    await dbHelper.insertDestination({
      'destination': _destinationController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'imagePath': _image?.path,
    });
    _refreshDestinations();
  }

  Future<void> _updateDestinations(int id) async {
    await dbHelper.updateDestination({
      'id': id,
      'destination': _destinationController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'imagePath': _image?.path,
    });
    _refreshDestinations();
  }

  void _deleteDestinations(int id) async {
    await dbHelper.deleteDestination(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Destination deleted')));
    _refreshDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          Container(
            //SearchBar
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset(
                        "assets/images/icon-search.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._destinations.map((destination) {
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
                                : const Icon(Icons.person, size: 50),
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _showForm(destination['id']),
                              icon: SvgPicture.asset(
                                "assets/images/icon-edit.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _deleteDestinations(destination['id']),
                              icon: SvgPicture.asset(
                                "assets/images/icon-delete.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: CircleBorder(),
        backgroundColor: Colors.blue[900],
        onPressed: () => _showForm(null),
      ),
    );
  }
}