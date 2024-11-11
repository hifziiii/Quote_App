import 'package:flutter/material.dart';
import 'package:login_signup/view/home/welcomescreen.dart';


void main() {
  runApp(QuotesApp());
}

class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes App',
      home: WelcomeScreen(),
    );
  }
}


