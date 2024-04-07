import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RewardScreen extends StatelessWidget {
  final String rewardData; // Data to be encoded in the QR code

  RewardScreen({required this.rewardData});

  @override
  Widget build(BuildContext context) {
    var data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             QrImageView(
                          data: data,
                          version: QrVersions.auto,
                          size: 250,
                          gapless: false,
                        ),

            SizedBox(height: 20.0),
            Text(
              'Scan this QR code to redeem your reward',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
