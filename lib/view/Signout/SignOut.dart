import 'package:flutter/material.dart';
import 'package:login_signup/view/signin/SignInPage.dart';

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to your login screen
      );
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Signing out...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
