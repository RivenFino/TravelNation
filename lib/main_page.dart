import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();

  final destination = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 250, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Card(
                surfaceTintColor: Color(0xFFAEE5FF),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 280,
                          child: const Text(
                            "Destination Create",
                            style: TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: destination,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Enter the Description",
                          labelText: "description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'destination is Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: location,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Enter the Description",
                          labelText: "description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'location is Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: description,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Enter the Description",
                          labelText: "description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'description is empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Add Data',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      // ElevatedButton(
                      //   style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStateProperty.all(Colors.blue),
                      //     shape: MaterialStateProperty.all(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //     ),
                      //   ),
                      //   child: const Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: Text(
                      //       "Submit",
                      //       style: TextStyle(color: Colors.white, fontSize: 16),
                      //     ),
                      //   ),
                      //   onPressed:() {
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
