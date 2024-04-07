// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// // import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

// class RewardScreen extends StatefulWidget {
//   @override
//   _RewardScreenState createState() => _RewardScreenState();
// }

// class _RewardScreenState extends State<RewardScreen> {
//   int rewardCount = 5; // Initial reward count

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reward Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             QrImageView(
//               data: 'Your QR Code Data Here', // Replace with your QR code data
//               version: QrVersions.auto,
//               size: 200.0,
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Reward Count: $rewardCount',
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _scanQR,
//         tooltip: 'Scan QR Code',
//         child: Icon(Icons.camera_alt),
//       ),
//     );
//   }

//   Future<void> _scanQR() async {
//     try {
//       var BarcodeScanner;
//       String qrResult = await BarcodeScanner.scan();
//       // Assuming the QR code data represents the reward
//       setState(() {
//         rewardCount++;
//       });
//     } on PlatformException catch (e) {
//       var BarcodeScanner;
//       if (e.code == BarcodeScanner.CameraAccessDenied) {
//         // Handle camera permission denied error
//         print('Camera permission was denied');
//       } else {
//         // Handle other errors
//         print('Error: $e');
//       }
//     } on FormatException {
//       // User returned without scanning anything
//       print('User returned without scanning anything');
//     } catch (e) {
//       // Handle other exceptions
//       print('Error: $e');
//     }
//   }
// }
