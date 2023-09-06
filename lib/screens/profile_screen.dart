import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('john.doe@example.com'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to change password screen
              },
              child: Text('Change Password'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to change information screen
              },
              child: Text('Change Information'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform logout action
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}