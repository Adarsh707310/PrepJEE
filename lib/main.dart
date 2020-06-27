import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
import 'package:jeeapp/screens/wrapper.dart';
import 'package:jeeapp/services/auth.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()));
  }
}
