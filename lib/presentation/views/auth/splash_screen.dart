import 'dart:async';

import 'package:flutter/material.dart';
import '../../../routes.dart' as route;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/hat.png'), // Make sure to adjust the path if needed
            const SizedBox(height: 20),
            const Text(
              'Your App Name', // Replace with your app name
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(route.signUp);
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
