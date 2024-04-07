
import 'package:flutter/material.dart';

class ProfileScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          
    // Code for Profile screen body
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('path_to_profile_image'),
        ),
        SizedBox(height: 20),
        Text('John Doe'),
        SizedBox(height: 10),
        Text('john.doe@example.com'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle edit profile button press
          },
          child: Text('Edit Profile'),
        ),
      ],
    )
  
        ],
      ),
    );
  }
}
    