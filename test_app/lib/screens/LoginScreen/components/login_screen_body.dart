
import 'package:flutter/material.dart';

class LoginScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          
    // Code for Login screen body
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle login button press
          },
          child: Text('Login'),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Handle forgot password button press
          },
          child: Text('Forgot Password?'),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Handle sign up button press
          },
          child: Text('Sign Up'),
        ),
      ],
    )
  
        ],
      ),
    );
  }
}
    