import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
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
        useMaterial3: true,
      ),
      home: DestinationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationAdd();
}

class _DestinationAdd extends State<DestinationPage> {
  @override
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
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text("Destination Form", 
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, 
                  ),
                  ), 
                  ),
                  
                  const SizedBox(height: 15), // Jarak antara teks dan TextField
                    Text(
                      'Destination Name *',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12
                      ),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
                              ),
                      ),
                    ),
                    ),
                  const SizedBox(height: 15), // Jarak antara teks dan TextField
                    Text(
                      'Location *',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12
                      ),
                    ),
                    Container(
                      height: 40,
                      child: 
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
                              ),
                      ),
                    ),
                    ),
                  const SizedBox(height: 15), // Jarak antara teks dan TextField
                    Text(
                      'Description *',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12
                      ),
                    ),
                    Container(
                      height: 40,
                      child: 
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(20, 80, 140, 1)),
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

                      }, 
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, 
                        ),
                      ),
                      child: 
                      Text('Add Destination',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),)
                    ),
                  ), // Jarak antara teks dan TextField
                    )
                  
                  
                ],
              ) ,
              
              ),
              
              
            ],
          ),
          ),
          ),
        ),
      ),

    );
  }
}
