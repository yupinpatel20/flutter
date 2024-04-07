import 'package:flutter/material.dart';
import 'package:test_app/screens/LoginScreen/login_screen.dart';
import 'package:test_app/screens/ServicerScreen/servicerscreen.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(),
                  ),
                );
              },
              child: Text('Donator'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ServicerScreen(),
                  ),
                );
              },
              child: Text('Servicer'),
            ),
          ],
        ),
      ),
    );
  }
}

enum UserType { donator, servicer }
