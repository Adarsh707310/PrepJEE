import 'package:jeeapp/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:jeeapp/screens/authentication/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
