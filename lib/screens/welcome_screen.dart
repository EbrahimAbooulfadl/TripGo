import 'package:flutter/material.dart';
import 'package:untitled/Components/roundedButtun.dart';
import 'package:untitled/constatns/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset(
                  'lib/Images/Logo.png',
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButtun('Sign In', () {
              Navigator.pushNamed(context, 'signin_screen');
            }),
            RoundedButtun('Sign Up', () {
              Navigator.pushNamed(context, 'signup_screen');
            })
          ],
        ),
      ),
    );
  }
}
