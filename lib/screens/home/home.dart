import 'package:flutter/material.dart';
import 'package:jeeapp/screens/drawerHome/drawerScreen.dart';
import 'package:jeeapp/screens/drawerHome/homeScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
    