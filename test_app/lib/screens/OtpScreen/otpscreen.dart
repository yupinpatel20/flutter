import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _submitOtp() {
    // Here, you can implement the logic to verify the OTP entered by the user
    String enteredOtp = otpController.text;
    print('Entered OTP: $enteredOtp');
    // Add your verification logic here
  }

  void _resendOtp() {
    // Here, you can implement the logic to resend the OTP
    print('Resending OTP...');
    // Add your resend OTP logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitOtp,
              child: Text('Submit OTP'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: _resendOtp,
              child: Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
