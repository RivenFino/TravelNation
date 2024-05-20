// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget{
//   HomePage({super.key, required this.username, required this.password,});

//   String username;
//   String password;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff5f5f5),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
//             // ignore: unnecessary_new
//             child: new Card(
//               surfaceTintColor: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start ,
//                   children: [
//                     const Text("Data Diri", style: TextStyle(fontSize: 64),),
//                     const Divider(
//                       height: 1,
//                     ),
//                     Text("Nama: $username", style: const TextStyle(fontSize: 24),), 
//                     Text("Kelas: $password", style: const TextStyle(fontSize: 24),),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: (){
//                           Navigator.pop(context);
//                         }, 
//                         child: const Text("Kembali"),
//                       ),
//                     ),
//                 ],
//                               ),
//               ),
//           ),
//         ),
//         ],
//       ),
//     );
//   }
// }