import 'package:flutter/material.dart';
import 'package:jeeapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/screens/authentication/authenticate.dart';
import 'package:jeeapp/screens/home/home.dart';
//import 'package:jeeapp/screens/admin/addQue.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
