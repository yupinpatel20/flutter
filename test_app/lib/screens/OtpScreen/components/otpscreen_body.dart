
import 'package:flutter/material.dart';

class OtpScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          
    // Code for OTP screen body
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text('Please enter the OTP sent to your mobile number'),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'OTP',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle verify OTP button press
          },
          child: Text('Verify OTP'),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Handle resend OTP button press
          },
          child: Text('Resend OTP'),
        ),
      ],
    )
  
        ],
      ),
    );
  }
}
    