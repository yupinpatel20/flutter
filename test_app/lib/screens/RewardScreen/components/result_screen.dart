// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "QR Scanner",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children:  [
//             QrImage(
//             data: 'https://google.com', // Provide your data here, such as a URL
//             size: 150,
//             version: QrVersions.auto,
//             ),

//             Text(
//               "Scanned result",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "RESULT",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//                 letterSpacing: 1,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width - 100,
//               height: 48,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//                 onPressed: () {},
//                 child: Text(
//                   "COPY",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
