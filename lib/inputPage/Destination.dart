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
          child: Column(
            children: [
              Text("Destination Form"),
              
            ],
          ),
        ),
      ),
    );
  }
}
