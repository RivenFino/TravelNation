import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
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
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
